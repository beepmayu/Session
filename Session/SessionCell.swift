//
//  SessionCell.swift
//  Session
//
//  Created by Mayu on 14/11/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


struct Session {
    var activityStartDate = ""
    var activityEndDate = ""
    var subject = ""
    var owner = ""
    var accoountName = ""
    var location = ""
    
    init(subject : String? ,owner : String? ,accountName : String? , location : String?, activityStartDate: String? , activityEndDate: String?) {
        self.subject = subject ?? "";
        self.activityStartDate = activityStartDate ?? "";
        self.activityEndDate = activityEndDate ?? "";
        self.owner = owner ?? "";
        self.accoountName = accoountName ?? "";
        self.location = location ?? "";

    }
 
  
}




class SessionCell : UITableViewCell {
    
    @IBOutlet weak var activityStartDateLbl: UILabel!
    
    @IBOutlet weak var sortAccountNameLbl: UILabel!
    @IBOutlet weak var ownerLbl: UILabel!
    @IBOutlet weak var accountNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    
    func setModel(_ session: Session){
        let dict = session.activityStartDate.shortTime()
        self.activityStartDateLbl.text = "\(dict["hour"]!) : \(dict["minute"]!) \n \(dict["xo"]!)"
        self.sortAccountNameLbl.text = session.accoountName
        self.accountNameLbl.text = session.accoountName
        self.locationLbl.text = session.location
        self.subjectLbl.text = session.subject
        self.ownerLbl.text = session.owner



        
    }
    
    
}




