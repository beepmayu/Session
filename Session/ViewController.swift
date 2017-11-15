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
import RxDataSources


class ViewController: UIViewController {

    @IBOutlet weak var sessionTw: UITableView!
    let disposalBg = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.sharedInstance.loadData()
        self.sessionTw.rowHeight = UITableViewAutomaticDimension;
        self.sessionTw.estimatedRowHeight = 150.0;
        sessionTw.sectionHeaderHeight = 50

        self.sessionTw.separatorStyle = .none

        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(configureCell: { (ds, tv,ip, item) -> SessionCell in
            let cell : SessionCell = tv.dequeueReusableCell(withIdentifier: "SessionCell", for: ip) as! SessionCell
            if let aSessionDict : [String : AnyObject] = item {
                    let eachSession = Session(subject: aSessionDict["Subject"] as? String, owner: aSessionDict["Owner"] as? String, accountName: aSessionDict["AccountName"] as? String, location: aSessionDict["Location"] as? String, activityStartDate: aSessionDict["ActivityStartDate"] as? String, activityEndDate: aSessionDict["ActivityEndDate"] as? String)

                    cell.setModel(eachSession)
                }
            return cell
        })

        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        
        Observable.just(DataManager.sharedInstance.sections)
            .bind(to: sessionTw.rx.items(dataSource: dataSource))
            .disposed(by: disposalBg)
     

    
    }

        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

