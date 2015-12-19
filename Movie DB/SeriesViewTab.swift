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
let OffsetSpeedTwo:CGFloat = 8.0
class SeriesViewTab:UIViewController, UITableViewDataSource,UITableViewDelegate{
    
    var seriesData:[JSON]?=[]
    let imageHeight:CGFloat = 150.0
    
    @IBAction func segmentControllMovie(sender: UISegmentedControl) {
        seriesData = []
        seriesTabelView.reloadData()
        switch sender.selectedSegmentIndex {
        case 0:
            print("case 0")
            makeNetworkRequest(util.getMovie("top_rated"))
            break
        case 1:
            print("case 1")
            makeNetworkRequest(util.getMovie("popular"))
            break
        case 2:
            print("case 2")
            makeNetworkRequest(util.getMovie("now_playing"))
            break
        case 3:
            print("case 3")
            makeNetworkRequest(util.getMovie("upcoming"))
            break
        default:
            break
            
        }
    }
    let util = Utils()
    @IBOutlet var seriesTabelView:UITableView!
    
    
    
    override func viewDidLoad() {
        makeNetworkRequest(util.getMovie("top_rated"))
        self.seriesTabelView.delegate = self
    }
  
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("table item click  path  = ")
        print(indexPath)
        var tabedViewController  = self.storyboard?.instantiateViewControllerWithIdentifier("movieDetId") as? MovieDetailViewController
        var jsValue:JSON?
        jsValue = self.seriesData?[indexPath.row]
        if jsValue!["id"] != nil {
            var id = jsValue!["id"]
      tabedViewController?.mId = String(id)
            print(jsValue?["id"])
        }
        self.presentViewController(tabedViewController!, animated: true, completion:nil)
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func makeNetworkRequest(url:String){
        let urlSeriesPopular = url//util.getMovie("top_rated")
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //  print("inside scroll")
       
        if let visibleCells = seriesTabelView.visibleCells as? [SeriesTableViewCell] {
            for parallaxCell in visibleCells {
                var yOffset = ((seriesTabelView.contentOffset.y - parallaxCell.frame.origin.y) / imageHeight) * OffsetSpeedTwo
                parallaxCell.offset(CGPointMake(0.0, yOffset))
            }
        }
    }

    
}
