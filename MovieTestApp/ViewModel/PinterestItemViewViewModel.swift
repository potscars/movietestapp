//
//  PinterestItemViewViewModel.swift
//  MovieTestApp
//
//  Created by owner on 17/09/2023.
//

import Foundation
import Combine
import UIKit

class PinterestItemViewViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var featuredImage: UIImage = UIImage()
    
    var disposedBag = Set<AnyCancellable>()
    let coreDataManager = CoreDataManager.shared
    
    init(title: String, urlString: String) {
        self.title = title
        
        let fetchedMovies = coreDataManager.fetchMovies(with: urlString)
        
        // Check if the image is existed.
        if fetchedMovies.count > 0 {
            guard let movie = fetchedMovies.first else {
                return
            }
            
            guard let imageData = movie.imageData else {
                self.loadImage(with: urlString)
                return
            }
            
            guard let loadedImage = UIImage(data: imageData) else { return }
            self.featuredImage = loadedImage
        } else {
            self.loadImage(with: urlString)
        }
    }
    
    private func loadImage(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        ImageLoader.shared.loadImage(from: url).sink{ [weak self] loadedImage in
            guard let self = self else { return }
            guard let loadedImage = loadedImage else { return }
            self.storeImageData(with: urlString, image: loadedImage)
            self.featuredImage = loadedImage
        }.store(in: &disposedBag)
    }
    
    // Store the image data once image finished download
    private func storeImageData(with imageURL: String, image: UIImage?) {
        
        guard let imageData = image?.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        coreDataManager.updateImageData(for: imageURL, with: imageData)
    }
}
