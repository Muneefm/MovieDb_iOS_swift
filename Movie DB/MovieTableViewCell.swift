//
//  MovieTableViewCell.swift
//  Movie DB
//
//  Created by Muneef M on 09/12/2015.
//  Copyright © 2015 com.mnf.moviedb. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var movieName:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    var populate:JSON?{
        didSet{
            self.movieName.text = self.populate?["title"].string
        }
    }
    
}
