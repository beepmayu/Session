//
//  Helper.swift
//  Session
//
//  Created by Mayu on 14/11/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import Foundation
import UIKit

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


extension UIColor {
    convenience init(_ hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
extension Date {
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
}
