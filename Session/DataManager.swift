//
//  DataManager.swift
//  Session
//
//  Created by Mayu on 14/11/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources


typealias Item = [String : AnyObject]

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}

class DataManager{
    static let sharedInstance = DataManager()
     let disposalBag = DisposeBag()
    
    var sections = [SectionOfCustomData]()
    var collection = [String : [[String : AnyObject]]]()
    
    func loadData(){
        if let path = Bundle.main.path(forResource: "JsonData", ofType: "json")
        {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                if let jsonResult1 = jsonResult as? Dictionary<String, AnyObject>, let sessions = jsonResult1["Sessions"] as? [[String : AnyObject]] {
                
                    _ = sessions.map({ dic in
                        let date1 : String = dic["ActivityStartDate"] as! String
                         let date = date1.shortTime()["date"]! as String
                        print(date)
                        if collection[date] == nil {
                            collection[date] = [dic]
                        }else{
                            var temp = collection[date]!
                            temp.append(dic)
                           let newSorted =  temp.sorted(by: { (dic1, dic2) -> Bool in
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                            if let date1 = dateFormatter.date(from: dic1["ActivityStartDate"] as? String ?? "") ,
                                let date2 = dateFormatter.date(from: dic2["ActivityStartDate"] as? String ?? ""){
                                return date1.compare(date2) == .orderedDescending
                            }
                            return false
                            })
                            collection[date] = newSorted
                        }
                      
                    })
                   let newCollection =  collection.sorted(by: { (dic1, dic2) -> Bool in
                        let first = Int(dic1.key) ?? 0
                        let second = Int(dic2.key) ?? 0
                        return first > second
                    })
                    for (key,value) in newCollection{
                        let eachSection = SectionOfCustomData(header: key.sectionDate(), items:value)
                        sections.append(eachSection)
                    }

                }
            } catch let e as NSError {
                print(e.localizedDescription)
                // handle error
            }

        }

    }
   
}
