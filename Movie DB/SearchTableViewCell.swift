//
//  SearchTableViewCell.swift
//  Movie DB
//
//  Created by Muneef M on 13/12/2015.
//  Copyright © 2015 com.mnf.moviedb. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var imagePoster:UIImageView!
    @IBOutlet var titleName:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(iden:Int,dataS:JSON){
        
    }
    
    
    var movieDataJson:JSON?{
        didSet{
            print("searchTable cell movie did set data")
            titleName.text = self.movieDataJson?["title"].string
        }
    }
    
    var seriesDataJson:JSON?{
        didSet{
            print("searchTable cell series did set data")
            print("string got = "+(seriesDataJson?["name"].string)!)
            print(seriesDataJson)
            titleName.text = self.seriesDataJson?["name"].string

        }
    }

    var castDataJson:JSON?{
        didSet{
            print("searchTable cast movie did set data")

        }
    }
    
}
