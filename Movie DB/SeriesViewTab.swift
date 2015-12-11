//
//  SeriesViewTab.swift
//  Movie DB
//
//  Created by Muneef M on 07/12/2015.
//  Copyright © 2015 com.mnf.moviedb. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class SeriesViewTab:UIViewController, UITableViewDataSource{
    
    let util = Utils()
    @IBOutlet var seriesTabelView:UITableView!
    var seriesData:[JSON]?=[]
    
    
    override func viewDidLoad() {
        makeNetworkRequest()
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func makeNetworkRequest(){
        let urlSeriesPopular = util.getSeriesUrl("popular")
        Alamofire.request(.GET, urlSeriesPopular)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    print("Validation Successful")
                    if let value = response.result.value {
                        var json = JSON(value)
                        if let data = json["results"].arrayValue as [JSON]?{
                            print("inside if result")
                            self.seriesData = data
                            self.seriesTabelView.reloadData()
                        }
                    }
                    
                    break
                case .Failure(let error):
                    print(error)
                }
        }

        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return seriesData?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("seriesIdent") as! SeriesTableViewCell
        cell.populate = self.seriesData?[indexPath.row]
        return cell
    }
    
    
}
