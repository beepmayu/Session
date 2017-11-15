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
typealias Invitee = [String : AnyObject]
typealias InviteeName = String

struct SectionOfSessionsData {
    var header: String
    var items: [Item]
}

extension SectionOfSessionsData: SectionModelType {
    
    init(original: SectionOfSessionsData, items: [Item]) {
        self = original
        self.items = items
    }
}

class DataManager{
    static let sharedInstance = DataManager()
    private let disposalBag = DisposeBag()
    
    var sections = [SectionOfSessionsData]()
    var selectedSession : Session?

    var defaultedInvitees = [Invitee]()
    
    private var collection = [String : [[String : AnyObject]]]()
    
    func loadData(){
        if let path = Bundle.main.path(forResource: "JsonData", ofType: "json")
        {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
             
                
                if let jsonResult1 = jsonResult as? Dictionary<String, AnyObject>, let sessions = jsonResult1["Sessions"] as? [[String : AnyObject]] {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                      _ =  sessions.filter({ (dict) -> Bool in
                                if let date = dateFormatter.date(from: dict["ActivityEndDate"] as! String){
                                    if  date.timeIntervalSinceNow > 0 {
                                        return true
                                    }
                                }
                            return false
                        }).map({ dic in
                            let date1 : String = dic["ActivityStartDate"] as! String
                            let date = date1.shortTime()["date"]! as String
                        print(date)
                        if collection[date] == nil {
                            collection[date] = [dic]
                        }else{
                            var temp = collection[date]!
                            temp.append(dic)
                           let newSorted =  temp.sorted(by: { (dic1, dic2) -> Bool in
                          
                            if let date1 = dateFormatter.date(from: dic1["ActivityStartDate"] as? String ?? "") ,
                                let date2 = dateFormatter.date(from: dic2["ActivityStartDate"] as? String ?? ""){
                                return date1.compare(date2) == .orderedAscending
                            }
                            return false
                            })
                            collection[date] = newSorted
                        }
                      
                    })
                   let newCollection =  collection.sorted(by: { (dic1, dic2) -> Bool in
                        let first = Int(dic1.key) ?? 0
                        let second = Int(dic2.key) ?? 0
                        return first < second
                    })
                    for (key,value) in newCollection{
                        let eachSection = SectionOfSessionsData(header: key.sectionDate(), items:value)
                        sections.append(eachSection)
                    }

                }
                
          
            } catch let e as NSError {
                print(e.localizedDescription)
                // handle error
            }

        }
        if let pathInvitee = Bundle.main.path(forResource: "JsonDataInvitees", ofType: "json"){
            do {

            let dataInvitee = try Data(contentsOf: URL(fileURLWithPath: pathInvitee), options: .alwaysMapped)
            let jsonResultInvitee = try JSONSerialization.jsonObject(with: dataInvitee, options: .mutableContainers)
            
            if let jsonResult1 = jsonResultInvitee as? Dictionary<String, AnyObject>, let invitees = jsonResult1["invitees"] as? [Invitee] {
                self.defaultedInvitees = invitees
                print(invitees)
            }
            }catch {
                
            }
        }

    }
   
}



struct Session {
    var activityStartDate = ""
    var activityEndDate = ""
    var subject = ""
    var owner = ""
    var accoountName = ""
    var location = ""
    var isonGoing = false
    var email = ""
    var phone = ""
    var opportunityName = ""
    var lead = ""
    var primaryContact = ""
    var description = ""
    var invitees = [Invitee]()

    
    init(subject : String? ,owner : String? ,accountName : String? , location : String?, activityStartDate: String? , activityEndDate: String?, email: String? , phone: String? , invitees : [Invitee]?  , opportunityName: String? , lead: String? , primaryContact: String? , description: String?) {
        self.subject = subject ?? "";
        self.activityStartDate = activityStartDate ?? "";
        self.activityEndDate = activityEndDate ?? "";
        self.owner = owner ?? "";
        self.accoountName = accountName ?? "";
        self.location = location ?? "";
        self.email = email ?? ""
        self.phone = phone ?? ""
        self.opportunityName = opportunityName ?? ""
        self.lead = lead ?? ""
        self.primaryContact = primaryContact ?? ""
        self.description = description ?? ""

        self.invitees = invitees ?? []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        if let date1 = dateFormatter.date(from: activityStartDate!) , let date2 = dateFormatter.date(from: activityEndDate!){
            self.isonGoing = Date().isBetween(date1, and: date2)

        }
        
        

        
        
    }
    
   
    
    
}



