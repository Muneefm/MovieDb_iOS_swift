//
//  MovieDetailViewController.swift
//  Movie DB
//
//  Created by Muneef M on 19/12/2015.
//  Copyright © 2015 com.mnf.moviedb. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
class MovieDetailViewController: UIViewController {

    @IBOutlet var backDropImage:UIImageView!
    let util = Utils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("inside movie detail view controller")
        self.makeMovieDetailNetworkRequest()
        // Do any additional setup after loading the view.
    }
    
    var movieDetData:JSON?
    
    func makeMovieDetailNetworkRequest(){
    var urlmDet = util.getMovie("140607")
        Alamofire.request(.GET, urlmDet)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    print("Validation Successful movie details ")
                    if let value = response.result.value {
                        var json = JSON(value)
                        if json["backdrop_path"] != nil {
                        self.loadImage(self.backDropImage, imageID: json["backdrop_path"].string!)
                        print(json["backdrop_path"].string)
                        }
                    
                    }
                    break
                case .Failure(let error):
                    print(error)
                }
        }

        
    }
    
    func loadImage(imageView:UIImageView,imageID id:String){
        let posterUrl = util.IMAGE_BASE_URL+id
        let URL = NSURL(string: posterUrl)!
        print("image url got is = "+posterUrl)
        print(URL)
        let imageP = UIImage(named: "movie_set")
        imageView.kf_setImageWithURL(URL,placeholderImage: imageP)

    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
