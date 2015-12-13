//
//  SearchViewController.swift
//  Movie DB
//
//  Created by Muneef M on 13/12/2015.
//  Copyright © 2015 com.mnf.moviedb. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {

    @IBOutlet var searchTable:UITableView!
    @IBOutlet var searchBar:UISearchBar!
    
    var searchData:[JSON] = []
    var scopInt:Int! = 0
    let utils = Utils()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchBar.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    searchTable.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        self.searchTable.delegate = self
        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count ?? 0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
         self.view.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("searchCellIdent") as! SearchTableViewCell
        print("table cell call ")
        if self.scopInt == 0 {
            print("table cell call 0 ")
            cell.movieDataJson = self.searchData[indexPath.row]
        }else if self.scopInt == 1 {
            print("table cell call 1")

            cell.seriesDataJson = self.searchData[indexPath.row]
            
        }else if self.scopInt == 2{
            print("table cell call 2 ")

            cell.castDataJson = self.searchData[indexPath.row]
        }
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("selected scope = ")
        print(selectedScope)
        searchData = []
        searchTable.reloadData()
        self.scopInt = selectedScope
        makeNetworkRequest(searchBar.text!)
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("search bar text  = "+searchBar.text!)
        searchData = []
        searchTable.reloadData()
        makeNetworkRequest(searchBar.text!)
    }

    func makeNetworkRequest( query:String){
        var baseUrl = utils.BASE_URL
        if self.scopInt == 0 {
            baseUrl = baseUrl+"search/movie?api_key="+utils.API_KEY+"&query="+query
        }else if self.scopInt == 1{
            baseUrl = baseUrl+"search/tv?api_key="+utils.API_KEY+"&query="+query
        }else if self.scopInt == 2{
            baseUrl = baseUrl+"search/movie?api_key="+utils.API_KEY+"&query="+query
        }
        
        print("alamo url = "+baseUrl)
         baseUrl = baseUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        Alamofire.request(.GET, baseUrl)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    print("Validation Successful search")
                    if let value = response.result.value {
                        var json = JSON(value)
                        if let data = json["results"].arrayValue as [JSON]?{
                            print("inside if result")
                            self.searchData = data
                            self.searchTable.reloadData()
                        }
                    }
                    
                    break
                case .Failure(let error):
                    print(error)
                }
        }

        
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
