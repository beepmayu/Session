//
//  DataManager.swift
//  Session
//
//  Created by Mayu on 14/11/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import Foundation
import RxSwift



class DataManager{
    static let sharedInstance = DataManager()
    var jsonData =  Variable([[String : AnyObject]]())
    var dayRecords = Variable([String]())
     let disposalBag = DisposeBag()
    var dataSource = [String : AnyObject]()
    
    func loadData(){
        if let path = Bundle.main.path(forResource: "JsonData", ofType: "json")
        {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                if let jsonResult1 = jsonResult as? Dictionary<String, AnyObject>, let sessions = jsonResult1["Sessions"] as? [[String : AnyObject]] {
                   let sortedSessions =  sessions.sorted(by: { dic1, dic2 -> Bool in
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                       if let date1 = dateFormatter.date(from: dic1["ActivityStartDate"] as? String ?? "") ,
                          let date2 = dateFormatter.date(from: dic2["ActivityStartDate"] as? String ?? ""){
                        return date1.compare(date2) == .orderedDescending
                        }
                        return false
                    })
                    
                    dataSource = sortedSessions.map({ dic -> [String : AnyObject]? in
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                        if let date1 : String = dic["ActivityStartDate"] as? String   {
                            let date = date1.shortTime()["date"]!
                            return [date1 : dic as AnyObject]
                        }
                        return nil
                    })
                    jsonData.value = sortedSessions
                }
            } catch let e as NSError {
                print(e.localizedDescription)
                // handle error
            }

        }

    }
   
}
