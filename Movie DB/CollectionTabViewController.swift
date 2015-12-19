//
//  CollectionTabViewController.swift
//  Movie DB
//
//  Created by Muneef M on 11/12/2015.
//  Copyright © 2015 com.mnf.moviedb. All rights reserved.
//

import UIKit
import Alamofire
let OffsetSpeed: CGFloat = 25.0

class CollectionTabViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate {

    @IBOutlet var collectionView:UICollectionView!
    
    let util = Utils()
    let ImageHeight: CGFloat = 318.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
            print("inside view didload third tab")
        makeNetworkRequest()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        print("inside view did appear third tab")
    }
    
    var mDataCollection:[JSON]? = []

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func makeNetworkRequest(){
        let urlReq = util.getSeriesUrl("popular")
        print("")
        Alamofire.request(.GET, urlReq)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    print("Validation Successful")
                    if let value = response.result.value {
                        var json = JSON(value)
                        if let data = json["results"].arrayValue as [JSON]?{
                            print("inside if result")
                            self.mDataCollection = data
                            self.collectionView.reloadData()
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
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mDataCollection?.count ?? 0
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("colectionIdent", forIndexPath: indexPath) as! MainCollectionViewCell
        cell.mData = mDataCollection![indexPath.row]
       cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 4

return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
      //  print("inside scroll")
          
        if let visibleCells = collectionView.visibleCells() as? [MainCollectionViewCell] {
            for parallaxCell in visibleCells {
                var yOffset = ((collectionView.contentOffset.y - parallaxCell.frame.origin.y) / ImageHeight) * OffsetSpeed
                parallaxCell.offset(CGPointMake(0.0, yOffset))
            }
        }
    }
    

}
