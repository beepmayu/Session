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

typealias Item = CustomData

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}
struct CustomData {
    var anInt: Int
    var aString: String
    var aCGPoint: CGPoint
}
extension SectionOfCustomData: SectionModelType {
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var sessionTw: UITableView!
    let disposalBg = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.sharedInstance.loadData()
        self.sessionTw.rowHeight = UITableViewAutomaticDimension;
        self.sessionTw.estimatedRowHeight = 150.0;
        self.sessionTw.separatorStyle = .none

        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(configureCell: { (ds, tv,ip, item) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(withIdentifier: "SessionCell", for: ip)
            return cell
        })

        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        
        let sections = [
            SectionOfCustomData(header: "First section", items: [CustomData(anInt: 0, aString: "zero", aCGPoint: CGPoint.zero), CustomData(anInt: 1, aString: "one", aCGPoint: CGPoint(x: 1, y: 1)) ]),
            SectionOfCustomData(header: "Second section", items: [CustomData(anInt: 2, aString: "two", aCGPoint: CGPoint(x: 2, y: 2)), CustomData(anInt: 3, aString: "three", aCGPoint: CGPoint(x: 3, y: 3)) ])
        ]
        Observable.just(sections)
            .bind(to: sessionTw.rx.items(dataSource: dataSource))
            .disposed(by: disposalBg)
     
        

        DataManager.sharedInstance.jsonData
            .asObservable()
            .bind(to: sessionTw.rx.items){ (collectionView, row, aSession) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell : SessionCell = self.sessionTw.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! SessionCell
                if let aSessionDict = aSession as? [String : AnyObject]{
                    let eachSession = Session(subject: aSessionDict["Subject"] as? String, owner: aSessionDict["Subject"] as? String, accountName: aSessionDict["Subject"] as? String, location: aSessionDict["Subject"] as? String, activityStartDate: aSessionDict["ActivityStartDate"] as? String, activityEndDate: aSessionDict["ActivityEndDate"] as? String)

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

