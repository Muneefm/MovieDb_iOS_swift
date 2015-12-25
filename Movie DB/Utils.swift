//
//  Utils.swift
//  Movie DB
//
//  Created by Muneef M on 07/12/2015.
//  Copyright © 2015 com.mnf.moviedb. All rights reserved.
//

import Foundation
import UIKit

class Utils{
    public  let BASE_URL="http://api.themoviedb.org/3/";
    public  let API_KEY="7cf008680165ec352b68dce08866495f";
    public let IMAGE_BASE_URL = "http://image.tmdb.org/t/p/w500"
    public func getSeriesUrl(url:String)->String{
        return BASE_URL+"tv/"+url+"?api_key="+API_KEY
    }
    
    public func getMovie(url:String)->String{
        return BASE_URL+"movie/"+url+"?api_key="+API_KEY
    }
   public static func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}