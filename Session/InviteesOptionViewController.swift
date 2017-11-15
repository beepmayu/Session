//
//  DetailsOptionViewController.swift
//  Session
//
//  Created by Mayu on 15/11/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import Foundation
import  UIKit
import  Eureka

class InviteesOptionViewController : FormViewController{
    
    override func viewDidLoad() {
        print("loaded view")
        super.viewDidLoad()
        loadInputDisplay()
        
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
        // Enables smooth scrolling on navigation to off-screen rows
        animateScroll = true
        // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
        rowKeyboardSpacing = 20
        
        
    }
    
    func loadInputDisplay(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        
        guard let selectedSession = DataManager.sharedInstance.selectedSession else {return }
        form +++
            
            Section("Session")
            <<< TextRow(){ row in
                row.title = "Subject"
                row.value = selectedSession.subject
                row.placeholder = "Enter text here"
            }
            <<< TextRow(){ row in
                row.title = "Location"
                row.value = selectedSession.location
                row.placeholder = "Enter text here"
            }
            <<< TextRow(){ row in
                row.title = "Type"
                row.value = selectedSession.subject
                row.placeholder = "Enter text here"
            }
            
            <<< DateRow(){
                $0.title = "Start"
                $0.value = dateFormatter.date(from: selectedSession.activityStartDate)
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            <<< DateRow(){
                $0.title = "End"
                $0.value = dateFormatter.date(from: selectedSession.activityEndDate)
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            <<< TextRow(){ row in
                row.title = "Account"
                row.value = selectedSession.accoountName
                row.placeholder = "Enter text here"
            }
            <<< TextRow(){ row in
                row.title = "Opportunity"
                row.placeholder = "Enter text here"
            }
            <<< TextRow(){ row in
                row.title = "Lead"
                row.placeholder = "Enter text here"
            }
            <<< PhoneRow(){
                $0.title = "Primary contact"
                $0.placeholder = "And numbers here"
            }
            <<< LabelRow(){ row in
                row.title = "Description"
            }
            <<< TextAreaRow(){ row in
                row.title = "Description"
                row.placeholder = "Enter text here"
            }

        
        
        
        
    }
    
    
    
}
