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
import RxCocoa


extension SessionCell{
    // 10255D
    func setOnGoing(){
        self.view1.backgroundColor = UIColor.init("10255D")
        self.view3.backgroundColor = UIColor.init("ffffff")
        self.activityStartDateLbl.textColor = UIColor.white
        contentView.layer.borderColor = UIColor.init("10255D").cgColor
        
    

    }
    func setOffGoing(){
        self.view1.backgroundColor = UIColor.init("ffffff")
        self.view3.backgroundColor = UIColor.init("E6E6E6")
        self.activityStartDateLbl.textColor = UIColor.black
        contentView.layer.borderColor = UIColor.init("E6E6E6").cgColor

    }
}
class SessionCell : UITableViewCell  {
    
    @IBOutlet weak var activityStartDateLbl: UILabel!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var sortAccountNameBtn: UIButton!
    @IBOutlet weak var ownerLbl: UILabel!
    @IBOutlet weak var accountNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    
    @IBOutlet weak var view3: UIView!
    
    
    let rxBag = DisposeBag()
    
    var session : Session!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.borderWidth = 2.0
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(10, 10, 10, 10))
        self.selectionStyle = .none
    }
    
    func setModel(_ session: Session){
        self.session = session;
        let dict = session.activityStartDate.shortTime()
        self.activityStartDateLbl.text = "\(dict["hour"]!) : \(dict["minute"]!) \n \(dict["xo"]!)"
        self.sortAccountNameBtn.setTitle(session.owner.sortName(), for: .normal)
        self.accountNameLbl.text = session.accoountName
        self.locationLbl.text = session.location
        self.subjectLbl.text = session.subject
        self.ownerLbl.text = session.owner
        if session.isonGoing{
            let value = "\(session.location)\n\(session.activityStartDate.shortTime()["hour"]!) : \(session.activityStartDate.shortTime()["minute"]!)\(session.activityStartDate.shortTime()["xo"]!) - \(session.activityEndDate.shortTime()["hour"]!):\(session.activityEndDate.shortTime()["minute"]!)\(session.activityEndDate.shortTime()["xo"]!)"
            self.locationLbl.text = value
            self.setOnGoing()
        }else{
            self.locationLbl.text = session.location
            self.setOffGoing()
        }
        
        self.sortAccountNameBtn.rx.tap
            .subscribe({ [unowned self] _ in
                let alert: UIAlertView = UIAlertView(title: "Proceed to call/email/sms", message: "\(self.session.email) & \(self.session.phone)", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                
            })
            .disposed(by: rxBag)
        

    }
    
    
}




