//
//  Helper.swift
//  Session
//
//  Created by Mayu on 14/11/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import Foundation


extension String{
    func shortTime() -> [String:String]{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
       let date = dateFormatter.date(from: self as String)
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.hour,.minute,.day,.weekday,.month,.year], from: date!)
        return ["hour":  String(format: "%02d", components.hour! > 12 ? components.hour! - 12 : components.hour!),
                "minute": String(format: "%02d", components.minute!)  ,
                "xo" : components.hour! < 12 ? "AM" : "PM",
                "date" : "\(String(format: "%02d", components.day!))\(String(format: "%02d", components.month!))\(String(format: "%04d", components.year!))"]
        
    }
    
    func sectionDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        guard let date = dateFormatter.date(from: self as String) else  { return ""}
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MMM dd, YYYY"
        
        return dateFormatter1.string(from: date)
    }
    
    func sortName() -> String{
        let fullNameArr = self.components(separatedBy: " ")
        return String(fullNameArr[0].prefix(1)) + String(fullNameArr[1].prefix(1))
  
    }
    
    
}
