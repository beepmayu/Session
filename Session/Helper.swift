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
        let components = calendar.dateComponents([.hour,.minute,.day], from: date!)
        return ["hour":  String(format: "%02d", components.hour! > 12 ? components.hour! - 12 : components.hour!),
                "minute": String(format: "%02d", components.minute!)  ,
                "xo" : components.hour! < 12 ? "AM" : "PM",
                "date" : "\(components.day!)"]
        
        
        
    }
}
