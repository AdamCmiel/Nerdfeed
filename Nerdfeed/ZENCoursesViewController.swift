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
            println(self.courses!)
            
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
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        println("calling \(__FUNCTION__)")
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = self.courses?.count
        
        println("rendering \(numberOfRows) courese")
        
        if (numberOfRows == nil) {
            return 0
        }
        else {
            return numberOfRows!
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("generating cell for row \(indexPath.row)")
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
}
