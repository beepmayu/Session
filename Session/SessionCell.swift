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

protocol DisplayableSession{
    var activityStartDate :String? {get set}
    
}

extension DisplayableSession{
    var shorttimeStr : String { return "M" }
    var amOpm  : String { return  "AM" }
    var shortAC : String {return "KL" }
}

struct Session : DisplayableSession{
    var activityStartDate: String?
    var subject : String?
    var owner : String?
    var accoountName : String?
    var location : String?
    
}



class SessionCell : UITableViewCell {
    
    @IBOutlet weak var activityStartDateLbl: UILabel!
    
    @IBOutlet weak var sortAccountNameLbl: UILabel!
    @IBOutlet weak var ownerLbl: UILabel!
    @IBOutlet weak var accountNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    
    func setModel(_ session: Session){
        self.activityStartDateLbl.text = session.shorttimeStr
        self.sortAccountNameLbl.text = session.shortAC
        self.accountNameLbl.text = session.accoountName
        self.locationLbl.text = session.location
        self.subjectLbl.text = session.subject
        self.ownerLbl.text = session.owner



        
    }
    
    
}




