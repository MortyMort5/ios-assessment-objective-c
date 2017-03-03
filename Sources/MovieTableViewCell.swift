//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Sterling Mortensen on 3/3/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    var movie: DMNMovie? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        guard let movie = movie else { return }
        titleLabel.text = movie.title;
        summaryLabel.text = movie.summary;
        ratingLabel.text = "\(movie.rating)";
    }
    
}
