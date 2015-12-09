//
//  ViewController.swift
//  Movie DB
//
//  Created by Muneef M on 07/12/2015.
//  Copyright © 2015 com.mnf.moviedb. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("inside view did load")
       
       // let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarController") as! TabedViewController
        //self.navigationController?.pushViewController(secondViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        print("inside view did appear")
        let tabedViewController  = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarController") as? TabedViewController
        self.presentViewController(tabedViewController!, animated: true, completion:nil)

    }
    
}

