//
//  HomeViewViewModel.swift
//  MovieTestApp
//
//  Created by owner on 16/09/2023.
//

import Foundation
import Combine

class HomeViewViewModel: ObservableObject {
    
    @Published var movies: Array<[Movie]> = []
    @Published var movs: Array<Movie> = []
    @Published var isFetchedData: Bool = false
    
    private let service: BaseService
    private var disposeBag = Set<AnyCancellable>()
    
    init(service: BaseService = HomeService()) {
        self.service = service
    }
    
    func fetchingData() {
        let fetchedMovies = CoreDataManager.shared.fetchAllMovies()
        
        guard fetchedMovies.count > 0 else {
            self.fetchHomeData()
            return
        }
        
        print("FETCHED MOVIES FROM CORE DATA \(fetchedMovies.count)")
        
        self.isFetchedData = true
        
        let tempMovies = fetchedMovies.map {
            Movie(movieID: Int($0.id), title: $0.title ?? "", year: $0.year ?? "", image: $0.image ?? "", runtime: $0.runtime ?? "", genre: $0.genre ?? "", summary: $0.summary ?? "", rating: $0.rating ?? "", directors: $0.directors ?? "", stars: $0.stars ?? "")
        }
        
        self.movies = tempMovies.chunks(size: tempMovies.count / 2)
    }
    
    func fetchHomeData() {
        self.service.request(with: .getAll, expecting: [Movie].self)
            .sink { res in
                
                switch res {
                case .failure(let error):
                    print("oops got an error \(error.localizedDescription)")
                default: break
                }
                
            } receiveValue: { [weak self] returnMovies in
                guard let self = self else { return }
                print("FETCHED MOVIES FROM API \(returnMovies.count)")
                self.isFetchedData = true
                self.movies = returnMovies.chunks(size: returnMovies.count / 2)
                CoreDataManager.shared.addBatchMovies(with: returnMovies)
            }
            .store(in: &disposeBag)
    }
    
    func clearMoviesFromCoreData() {
        let fetchedMovies = CoreDataManager.shared.fetchAllMovies()
        
        guard fetchedMovies.count > 0 else {
            return
        }
        
        CoreDataManager.shared.deleteAllMovies { deleted in
            if deleted {
                self.fetchHomeData()
            }
        }
    }
}
