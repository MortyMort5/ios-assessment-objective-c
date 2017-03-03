//
//  MovieSearchTableViewController.swift
//  MovieSearch
//
//  Created by Sterling Mortensen on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self;
    }
    
    var movies: [DMNMovie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData();
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return MovieTableViewCell() }
        
        let movie = self.movies[indexPath.row];
        cell.movie = movie;
        
        return cell
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return };
        DMNMovieController.sharedInstance().fetchMovies(bySearchTerm: searchTerm) { (movies, error) in
            guard let movies = movies as? [DMNMovie] else { return };
            self.movies = movies;
        }
    }
}
