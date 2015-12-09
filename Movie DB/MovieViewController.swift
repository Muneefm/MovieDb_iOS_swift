//
//  MovieViewController.swift
//  Movie DB
//
//  Created by Muneef M on 07/12/2015.
//  Copyright © 2015 com.mnf.moviedb. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class MovieViewController:UIViewController, UITableViewDataSource{
    
    let util = Utils()
    var movieData:[JSON]? = []
    
    @IBOutlet var movieTableView: UITableView!
    
    override func viewDidLoad() {
        print("inside view did Load for movie tab")

        networkRequest()

    }
    
    override func viewDidAppear(animated: Bool) {
        print("inside view did appear for movie tab")
    }
    
    func networkRequest(){
        let url_top_rated = util.getMovie("top_rated")
        print("top rated url  = "+url_top_rated)
        
        Alamofire.request(.GET, url_top_rated)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    print("Validation Successful")
                    if let value = response.result.value {
                        var json = JSON(value)
                        if let data = json["results"].arrayValue as [JSON]?{
                         self.movieData = data
                            self.movieTableView.reloadData()
                        }
                    }
                    
                    break
                case .Failure(let error):
                    print(error)
                }
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("movieIdent") as! MovieTableViewCell
        cell.populate = self.movieData?[indexPath.row]
        return cell
    }
}