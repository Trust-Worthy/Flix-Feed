//
//  DetailViewController.swift
//  ios101-lab6-flix
//
//  Created by Jonathan Bateman on 7/16/25.
//

import UIKit
import NukeExtensions

class   DetailViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var voteLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // property to store the passed in movie
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK: - Configure the Labels
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        // Unwrap the optional vote average
        if let voteAverage = movie.voteAverage {
            
            voteLabel.text = "Vote Average: \(voteAverage)"
        } else {
            // if vote average is nil, set vote average label text to empty string
            voteLabel.text = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        // unwrap the optional release date
        if let releaseDate = movie.releaseDate {
            let releaseDateString = dateFormatter.string(from: releaseDate)
            releaseDateLabel.text = "Release Date: \(releaseDateString)"
        } else {
            // if release date is nil
            releaseDateLabel.text = ""
        }
        
        
        // MARK: - Configure the image views
        if let posterPath = movie.posterPath,
        // create a url by appending the poster path to the base url
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) {
            NukeExtensions.loadImage(with: imageURL, into: posterImageView)
            
        }
        
        if let backdropPath = movie.backdropPath,
           
        // Create a url by appending the backdrop path to the base url
        let imageUrl = URL(string:  "https://image.tmdb.org/t/p/w500" + backdropPath) {
            
            // use the nukeExtensions library's load image
            NukeExtensions.loadImage(with: imageUrl, into: backdropImageView)
            
        
        }
        
    }
    

  
}
