//
//  HomeDetailViewViewModel.swift
//  MovieTestApp
//
//  Created by owner on 16/09/2023.
//

import Foundation
import Combine
import UIKit

class HomeDetailViewViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var rating: String = ""
    @Published var directors: String = ""
    @Published var stars: String = ""
    @Published var description: String = ""
    @Published var featuredImage: UIImage = UIImage()
    
    var disposedBag = Set<AnyCancellable>()
    
    init(movie: Movie) {
        self.configData(with: movie)
    }
    
    private func configData(with movie: Movie) {
        self.title = movie.title
        self.rating = movie.rating
        
        self.directors = movie.directors.removingCharacters(from: .newlines)
        
        self.stars = movie.stars.removingCharacters(from: .newlines)
        
        self.description = movie.summary
    
        guard let url = URL(string: movie.image) else { return }
        
        ImageLoader.shared.loadImage(from: url).sink{ [weak self] loadedImage in
            guard let self = self else { return }
            guard let loadedImage = loadedImage else { return }
            self.featuredImage = loadedImage
        }.store(in: &disposedBag)
    }
}
