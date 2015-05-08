//
//  Courses.swift
//  Nerdfeed
//
//  Created by Adam Cmiel on 5/7/15.
//  Copyright (c) 2015 Adam Cmiel. All rights reserved.
//

import Foundation

struct Course : Printable {
    var end_date : String
    var instructors : String
    var location : String
    
    var description: String {
        return "\(end_date) \(instructors) \(location)"
    }
}

struct CourseDescription : Printable {
    var title : String
    var url : String
    var courses : Array<Course>
    init(data: Dictionary<String, AnyObject>) {
        courses = [Course]()
        
        title = data["title"] as! String
        url = data["url"] as! String
        
        for courseData in data["upcoming"] as! Array<AnyObject> {
            courses.append(Course(end_date: courseData["end_date"] as! String,
                                  instructors: courseData["instructors"] as! String,
                                  location: courseData["location"] as! String))
        }
    }
    
    var description: String {
        var out = "\(title)\n"
        
        for course in courses {
            out += "\(course)\n"
        }
        
        return out + "\n"
    }
}

struct Courses : Printable {
    var courseDescriptions : Array<CourseDescription>
    init(data: Array<AnyObject>) {
        courseDescriptions = [CourseDescription]()
        for courseDescription in data {
            courseDescriptions.append(CourseDescription(data: courseDescription as! Dictionary<String, AnyObject>))
        }
    }
    
    var description : String {
        var out = ""
        
        for courseDescription in courseDescriptions {
            out += "\(courseDescription)"
        }
        
        return out
    }
    
    var count : Int {
        get { return courseDescriptions.count }
    }
    
    subscript(index: Int) -> CourseDescription {
        get { return courseDescriptions[index] }
    }
}
