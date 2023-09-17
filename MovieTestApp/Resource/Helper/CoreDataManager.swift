//
//  CoreDataManager.swift
//  MovieTestApp
//
//  Created by owner on 17/09/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let persistentContainer = NSPersistentContainer(name: "MovieModel")
    private let movieRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {
        load()
    }
    
    func load() {
        self.persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                return
            }
        }
    }
    
    func fetchAllMovies() -> [MovieEntity] {
        
        var movies: [MovieEntity] = []
        
        do {
            movies = try viewContext.fetch(movieRequest)
        } catch {
            print("Error failed to fetch...")
        }
        
        return movies
    }
    
    func addMovie(with movie: Movie) {
        
        guard checkIfUserExisted(for: movie.title, id: Int32(movie.movieID)) else {
            print("Existed!")
            return
        }
        
        self.assignMovieToEntity(with: movie)
        
        save()
    }
    
    func addBatchMovies(with movies: [Movie]) {
        
        _ = movies.compactMap { movie in
            guard checkIfUserExisted(for: movie.title, id: Int32(movie.movieID)) else {
                print("Existed!")
                return
            }
            
            self.assignMovieToEntity(with: movie)
        }
        
        save()
    }
    
    private func assignMovieToEntity(with movie: Movie) {
        let movieEntity = MovieEntity(context: viewContext)
        movieEntity.id = Int32(movie.movieID)
        movieEntity.title = movie.title
        movieEntity.rating = movie.rating
        movieEntity.stars = movie.stars
        movieEntity.directors = movie.directors
        movieEntity.summary = movie.summary
        movieEntity.year = movie.year
        movieEntity.runtime = movie.runtime
        movieEntity.image = movie.image
        movieEntity.genre = movie.genre
    }
    
    func updateData(for movie: Movie) {
        
        let fetchedMovies = self.fetchSingleMovie(for: movie.title)
        guard let fetchedMovie = fetchedMovies.first else { return }
        
        fetchedMovie.title = movie.title
        fetchedMovie.rating = movie.rating
        print("Updated for movie: \(movie.title)")
        save()
    }
    
    func updateImageData(for imageURL: String, with imageData: Data) {
        let fetchedMovies = self.fetchMovies(with: imageURL)
        guard let fetchedMovie = fetchedMovies.first else { return }
        fetchedMovie.imageData = imageData
        save()
    }
    
    func fetchMovies(with imageURL: String) -> [MovieEntity] {
        
        var movies: [MovieEntity] = []
        
        do {
            movieRequest.predicate = NSPredicate(format: "image == %@", imageURL)
            movies = try viewContext.fetch(movieRequest)
            return movies
        } catch {
            print("Error saving context \(error)")
        }
        
        return movies
    }
    
    func fetchSingleMovie(for title: String) -> [MovieEntity] {
        
        var movies: [MovieEntity] = []
        
        do {
            movieRequest.predicate = NSPredicate(format: "title == %@", title)
            movies = try viewContext.fetch(movieRequest)
            return movies
        } catch {
            print("Error saving context \(error)")
        }
        
        return movies
    }
    
    // Used to check if the data is existed or not.
    private func checkIfUserExisted(for title: String, id: Int32) -> Bool {
        do {
            movieRequest.predicate = NSPredicate(format: "title == %@ AND id == %d", title, id)
            let numberOfRecords = try viewContext.count(for: movieRequest)
            return numberOfRecords == 0
        } catch {
            print("Error saving context \(error)")
        }
        
        return false
    }
    
    // Delete all the data.
    func deleteAllMovies(completion: @escaping (Bool) -> ()) {
        do {
            let movies = try viewContext.fetch(movieRequest)
            _ = movies.map { viewContext.delete($0) }
            save()
            completion(true)
        } catch {
            print("Error delete entities: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    // Save core data.
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch let error {
                print("Error saving... \(error.localizedDescription)")
            }
        }
    }
}
