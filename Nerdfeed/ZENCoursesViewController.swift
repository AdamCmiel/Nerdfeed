//
//  ZENCoursesViewController.swift
//  Nerdfeed
//
//  Created by Adam Cmiel on 5/7/15.
//  Copyright (c) 2015 Adam Cmiel. All rights reserved.
//

import UIKit

let cellReuseIdentifier = "UITableViewCell"

class ZENCoursesViewController: UITableViewController {
    
    var courses: Courses?
    var webViewController : ZENWebViewController?
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
        self.navigationItem.title = "BNR Courses"
        self.fetchFeed()
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(style: UITableViewStyle.Plain)
    }
    
    override init(nibName nibNameOrNil:String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    func fetchFeed() {
        let requestString = "http://bookapi.bignerdranch.com/courses.json"
        let url = NSURL(string: requestString)!
        let req = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithRequest(req) { (data, response, error) in
            let json = NSString(data: data, encoding: NSUTF8StringEncoding)!
            let deserializedData: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil)
            
            self.courses = Courses(data: deserializedData!["courses"] as! Array<AnyObject>)
            
            dispatch_async(dispatch_get_main_queue()) {
                println("reloading the table \(self.courses!.count)")
                self.tableView.reloadData()
            }
        }
        
        dataTask.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:cellReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = self.courses?.count
        return (numberOfRows == nil) ? 0 : numberOfRows!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        var course = self.courses![indexPath.row]
        cell.textLabel!.text = course.title
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let course: CourseDescription = self.courses![indexPath.row]
        
        self.webViewController?.title = course.title
        self.webViewController?.URL = NSURL(string: course.url)
        
        self.navigationController?.pushViewController(self.webViewController!, animated: true)
    }
}
