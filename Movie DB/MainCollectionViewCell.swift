//
//  MainCollectionViewCell.swift
//  Movie DB
//
//  Created by Muneef M on 11/12/2015.
//  Copyright © 2015 com.mnf.moviedb. All rights reserved.
//

import UIKit
import Kingfisher


class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var nameTitle:UILabel!
    @IBOutlet var posterImage:UIImageView!
    let ImageHeight: CGFloat = 318.0
    let OffsetSpeed: CGFloat = 25.0
   var imageOffset:CGPoint!
    var imageVi:UIImage!
    func offset(offset: CGPoint) {
        posterImage.frame = CGRectOffset(self.posterImage.bounds, offset.x, offset.y)
    }
    
    var mData:JSON?{
        didSet{
            print("inside did set of cell data")
            self.nameTitle.text = mData?["name"].string
            
            let util  = Utils()
            let posterUrl = util.IMAGE_BASE_URL+(self.mData?["poster_path"].string)!
            let URL = NSURL(string: posterUrl)!
            print("image url got is = "+posterUrl)
            print(URL)
            
            self.posterImage.kf_setImageWithURL(URL, placeholderImage: nil)
            
            
        }
    }
    
}
