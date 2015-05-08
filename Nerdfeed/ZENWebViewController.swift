//
//  ZENWebViewController.swift
//  Nerdfeed
//
//  Created by Adam Cmiel on 5/8/15.
//  Copyright (c) 2015 Adam Cmiel. All rights reserved.
//

import UIKit

class ZENWebViewController: UIViewController, UIWebViewDelegate {
    
    var URL : NSURL? {
        didSet {
            if (self.URL != nil) {
                var req = NSURLRequest(URL: self.URL!)
                self.webView?.loadRequest(req)
            }
        }
    }
    
    var wvTitle: String?
    var URLToSet: NSURL?
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    init() {
        super.init(nibName: "ZENWebViewController", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        
        println("view did load \(self.view) \(self.webView)")
        self.webView?.delegate = self
        
        self.URL = self.URLToSet!
        self.title = self.wvTitle!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: AnyObject) {
        self.webView.goBack()
    }
    
    @IBAction func goForward(sender: AnyObject) {
        self.webView.goForward()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        forwardButton.enabled = self.webView.canGoForward
        backButton.enabled = self.webView.canGoBack
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
