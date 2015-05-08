//
//  ZENWebViewController.swift
//  Nerdfeed
//
//  Created by Adam Cmiel on 5/8/15.
//  Copyright (c) 2015 Adam Cmiel. All rights reserved.
//

import UIKit

class ZENWebViewController: UIViewController {
    
    var URL : NSURL? {
        didSet {
            if (self.URL != nil) {
                var req = NSURLRequest(URL: self.URL!)
                (self.view as! UIWebView!).loadRequest(req)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        var wv = UIWebView()
        wv.scalesPageToFit = true
        self.view = wv
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
