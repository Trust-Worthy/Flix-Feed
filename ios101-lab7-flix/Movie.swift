//
//  Movie.swift
//  ios101-lab6-flix
//

import Foundation

struct MovieFeed: Decodable {
    let results: [Movie]
}

// Methods for saving, retrieving and removing from favorites
// from User Defaults
extension Movie {
    
    static var favoritesKey: String {
        return "Favorites"
    }
    
    // Save an array of favorites movies to UserDefaults
    static func save(_ movies: [Movie], forKey key: String) {
        
        // 1. Create an instance of UserDefaults
        let defaults = UserDefaults.standard
        
        // 2. Try to encode the arry of `Movie` objects to `Data`
        let encodedData = try! JSONEncoder().encode(movies)
        
        // 3. Save the encoded movie `Data` to UserDefaults
        defaults.set(encodedData, forKey: key)
    }
    
    static func getMovies(forKey key: String) -> [Movie] {
        
        // 1. Create an instance of UserDefaults
        let defaults = UserDefaults.standard
        
        // 2. Get any favorite movies saved to UserDefaults if any exist
        if let data = defaults.data(forKey: key) {
            
            // 3. Try to decode the movie `Data` to `Movie` objects
            let decodedMovies = try! JSONDecoder().decode([Movie].self, from: data)
            
            // 4. if step 2 & 3 are successful , return the array of movies
            return decodedMovies
        } else {
            // 5. otherwise return an empty array
            return []
        }
    }
    
    // Start of the instance methods
    
    func addToFavorites() {
        
        // 1. Get all favorite movies from UserDefaults
        // favoriteMovies is a var so that it can be modified
        var favoriteMovies = Movie.getMovies(forKey: Movie.favoritesKey)
        
        // 2. Add the movie to the favorite movie array
        // This method is available on "instances" of a movie, so I can reference the movie this method is being called on using `self`.
        favoriteMovies.append(self)
        
        // 3. Save the updated favorite movie array
        Movie.save(favoriteMovies, forKey: Movie.favoritesKey)
    }
    
    func removeFromFavorites() {
        
        // 1. Get all favorite movies from UserDefaults
        var favoriteMovies = Movie.getMovies(forKey: Movie.favoritesKey)
        
        // 2. remove all movies from the array that match the movie instance this method is being called on aka `self`
        // The `removeAll` method iterates through each movie in the array and passes the movie into a closure where it can be used to determine if it should be removed from the array.
        
        favoriteMovies.removeAll { movie in
//            3. If a given movie passed into the closure is equal to `self` (i.e. the movie calling the method) we want to remove it. Returning a `Bool` of `true` removes the given movie.
                return self == movie
        }
        
        // 4. Save the updated favorite movies array
        Movie.save(favoriteMovies, forKey: Movie.favoritesKey)
        
        
    }
    
}

struct Movie: Codable, Equatable {
    let title: String
    let overview: String
    let posterPath: String? // Path used to create a URL to fetch the poster image

    // MARK: Additional properties for detail view
    let backdropPath: String? // Path used to create a URL to fetch the backdrop image
    let voteAverage: Double?
    let releaseDate: Date?

    // MARK: ID property to use when saving movie
    let id: Int

    // MARK: Custom coding keys
    // Allows us to map the property keys returned from the API that use underscores (i.e. `poster_path`)
    // to a more "swifty" lowerCamelCase naming (i.e. `posterPath` and `backdropPath`)
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case id
    }
}
