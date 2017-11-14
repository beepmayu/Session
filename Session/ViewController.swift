//
//  ViewController.swift
//  Session
//
//  Created by Mayu on 14/11/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var sessionTw: UITableView!
    let disposalBg = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.sharedInstance.loadData()
        self.sessionTw.rowHeight = UITableViewAutomaticDimension;
        self.sessionTw.estimatedRowHeight = 150.0;
        self.sessionTw.separatorStyle = .none


        DataManager.sharedInstance.jsonData
            .asObservable()
            .bind(to: sessionTw.rx.items){ (collectionView, row, aSession) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell : SessionCell = self.sessionTw.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! SessionCell
                if let aSessionDict = aSession as? [String : AnyObject]{
                    let eachSession = Session(activityStartDate: aSessionDict["ActivityStartDate"] as? String, subject: aSessionDict["Subject"] as? String, owner: aSessionDict["Subject"] as? String, accoountName: aSessionDict["Subject"] as? String, location:  aSessionDict["Subject"] as? String)
                    cell.setModel(eachSession)
                }
                return cell
        }.disposed(by: disposalBg)
        
        }

        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

