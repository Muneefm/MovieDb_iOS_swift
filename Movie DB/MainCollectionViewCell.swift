//
//  MainCollectionViewCell.swift
//  Movie DB
//
//  Created by Muneef M on 11/12/2015.
//  Copyright © 2015 com.mnf.moviedb. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var nameTitle:UILabel!
    
    
    
    var mData:JSON?{
        didSet{
            print("inside did set of cell data")
        }
    }
    
}
