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
    let util  = Utils()
    
    var movieDataJson:JSON?{
        didSet{
            self.imagePoster.image = nil
            print("searchTable cell movie did set data")
            if self.movieDataJson?["title"].string != nil {
            titleName.text = self.movieDataJson?["title"].string
                
            if self.movieDataJson?["poster_path"].string != nil{
                
                var posterUrl = util.IMAGE_BASE_URL+((self.movieDataJson?["poster_path"].string))!
                let URL = NSURL(string: posterUrl)!
                self.imagePoster.kf_setImageWithURL(URL,placeholderImage: nil)

            }else{
                print("poster path nil")
            }

        }
    }
    }
    
    var seriesDataJson:JSON?{
        didSet{
            self.imagePoster.image = nil

            print("searchTable cell series did set data")
          //  print("string got = "+(seriesDataJson?["name"].string)!)
            print(seriesDataJson)
            if self.seriesDataJson?["name"].string != nil {
            titleName.text = self.seriesDataJson?["name"].string
            }
            if self.movieDataJson?["poster_path"].string != nil {
            let posterUrl = util.IMAGE_BASE_URL+(self.movieDataJson?["poster_path"].string)!
            let URL = NSURL(string: posterUrl)!
            self.imagePoster.kf_setImageWithURL(URL,placeholderImage: nil)
            }

        }
    }

    var castDataJson:JSON?{
        didSet{
            print("searchTable cast movie did set data")

        }
    }
    
}
