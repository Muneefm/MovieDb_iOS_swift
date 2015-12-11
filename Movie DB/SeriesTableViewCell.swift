//
//  SeriesTableViewCell.swift
//  Movie DB
//
//  Created by Muneef M on 11/12/2015.
//  Copyright © 2015 com.mnf.moviedb. All rights reserved.
//

import UIKit

class SeriesTableViewCell: UITableViewCell {
    
    @IBOutlet var seriesName:UILabel!
    
    
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
            print("inside populate json")
            self.seriesName.text = self.populate?["name"].string

        }
    }
    

}
