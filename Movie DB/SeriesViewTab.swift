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
    let imageHeight:CGFloat = 142.0
    var currentPage:Int = 0
    var totalPage:Int = 0
    var caseNow:Int=0
    var requestedPage:Int=0
    var isLoading:Bool = false
    
    @IBAction func segmentControllMovie(sender: UISegmentedControl) {
        seriesData = []
        seriesTabelView.reloadData()
        switch sender.selectedSegmentIndex {
        case 0:
            print("case 0")
            caseNow = 0
            makeNetworkRequest(util.getMovie("top_rated"),shouldAddDataToList: false)
            break
        case 1:
            print("case 1")
              caseNow = 1
            makeNetworkRequest(util.getMovie("popular"),shouldAddDataToList: false)
            break
        case 2:
              caseNow = 2
            print("case 2")
            makeNetworkRequest(util.getMovie("now_playing"),shouldAddDataToList: false)
            break
        case 3:
            print("case 3")
              caseNow = 3
            makeNetworkRequest(util.getMovie("upcoming"),shouldAddDataToList: false)
            break
        default:
            break
            
        }
    }
    let util = Utils()
    @IBOutlet var seriesTabelView:UITableView!
    
    
    
    override func viewDidLoad() {
        makeNetworkRequest(util.getMovie("top_rated"),shouldAddDataToList: false)
        self.seriesTabelView.delegate = self
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("inside prepare for segue")
         if let destination = segue.destinationViewController as? MovieDetailViewController {
        var va = seriesTabelView.indexPathForSelectedRow!.row
            var ids = self.seriesData![va]
        print(va)
            if ids["id"] != nil {
            destination.mId = String(ids["id"])
            }
        }
      /*  if let index = seriesTabelView.indexPathForSelectedRow!.row {
         //   destination.blogName = swiftBlogs[blogIndex]
        }*/
    }
  
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("table item click  path  = ")
       /* print(indexPath)
        var tabedViewController  = self.storyboard?.instantiateViewControllerWithIdentifier("movieDetId") as? MovieDetailViewController
        var jsValue:JSON?
        jsValue = self.seriesData?[indexPath.row]
        if jsValue!["id"] != nil {
            var id = jsValue!["id"]
      tabedViewController?.mId = String(id)
            print(jsValue?["id"])
        }
        self.presentViewController(tabedViewController!, animated: true, completion:nil)*/
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func makeNetworkRequest(url:String, shouldAddDataToList list:Bool){
        let urlSeriesPopular = url//util.getMovie("top_rated")
        Alamofire.request(.GET, urlSeriesPopular)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    print("Validation Successful")
                    if let value = response.result.value {
                        var json = JSON(value)
                        if json["page"] != nil {
                            self.currentPage = json["page"].int!
                            self.totalPage = json["total_pages"].int!
                        }
                        
                        if let data = json["results"].arrayValue as [JSON]?{
                            print("inside if result")
                            if list {
                             self.seriesData?.appendContentsOf(data)
                                self.seriesTabelView.reloadData()
                                self.isLoading = false
                            }else{
                            self.seriesData = data
                            self.seriesTabelView.reloadData()
                            }
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
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("inside scroll view did end dragging,")
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //  print("inside scroll")
       
        if let visibleCells = seriesTabelView.visibleCells as? [SeriesTableViewCell] {
            for parallaxCell in visibleCells {
                var yOffset = ((seriesTabelView.contentOffset.y - parallaxCell.frame.origin.y) / imageHeight) * OffsetSpeedTwo
                parallaxCell.offset(CGPointMake(0.0, yOffset))
            }
        }
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            //reach bottom
            
            if self.currentPage<self.totalPage&&(!isLoading) {
                self.isLoading = true
                let prefixPage = "&page="+String((currentPage+1))
                print("reach at the bottom prefix page = "+prefixPage)
                switch(caseNow){
                case 0:
                    makeNetworkRequest(util.getMovie("top_rated")+prefixPage,shouldAddDataToList: true)
                    break;
                case 1:
                    makeNetworkRequest(util.getMovie("popular")+prefixPage,shouldAddDataToList: true)
                    break
                case 2:
                    makeNetworkRequest(util.getMovie("now_playing")+prefixPage,shouldAddDataToList: true)
                    break
                case 3:
                    makeNetworkRequest(util.getMovie("upcoming")+prefixPage,shouldAddDataToList: true)
                    break
                default:
                    break
                }
            }
        }
    }

    
}
