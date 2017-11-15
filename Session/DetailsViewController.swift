//
//  DetailsViewController.swift
//  Session
//
//  Created by Mayu on 15/11/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import Foundation
import  Eureka

typealias Emoji = String


class DetailsViewController : FormViewController {
    var editableForm = false
    override func viewDidLoad() {
        print("loaded view")
        super.viewDidLoad()
        loadInputDisplay()
     
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
        // Enables smooth scrolling on navigation to off-screen rows
        animateScroll = true
        tableView.isEditing = false
        // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
        rowKeyboardSpacing = 20
        
        let rightButtonItem1 =  UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(rightButtonAction(sender:)))
        self.navigationItem.rightBarButtonItem = rightButtonItem1
        
        
    }
    @objc func rightButtonAction(sender: UIBarButtonItem){
        self.editableForm = !editableForm
        
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
                row.placeholder = ""
                row.disabled = editableForm ? true : false
            }
            <<< TextRow(){ row in
                row.title = "Location"
                row.value = selectedSession.location
                row.placeholder = ""
                row.disabled = editableForm ? true : false

                
            }
            <<< TextRow(){ row in
                row.title = "Type"
                row.value = selectedSession.subject
                row.placeholder = ""
                row.disabled = editableForm ? true : false

            }
         
            <<< DateRow(){
                $0.title = "Start"
                $0.value = dateFormatter.date(from: selectedSession.activityStartDate)
                $0.disabled = editableForm ? true : false

            }
            <<< DateRow(){
                $0.title = "End"
                $0.value = dateFormatter.date(from: selectedSession.activityEndDate)
                $0.disabled = editableForm ? true : false

            }
            <<< TextRow(){ row in
                row.title = "Account"
                row.value = selectedSession.accoountName
                row.placeholder = ""
                row.disabled = editableForm ? true : false

            }
            <<< TextRow(){ row in
                row.title = "Opportunity"
                row.value = selectedSession.opportunityName
                row.placeholder = ""
                row.disabled = editableForm ? true : false

            }
            <<< TextRow(){ row in
                row.title = "Lead"
                row.value = selectedSession.lead
                row.placeholder = ""
                row.disabled = editableForm ? true : false

            }
            <<< TextRow(){ row in
                row.title = "Primary contact"
                row.value = selectedSession.primaryContact
                row.placeholder = ""
                row.disabled = editableForm ? true : false

            }
            <<< LabelRow(){ row in
                row.title = "Description"
                
                
            }
            <<< TextAreaRow(){ row in
                row.title = "Description"
                row.value = selectedSession.description
                row.placeholder = ""
                row.disabled = editableForm ? true : false

            }
            
            +++ Section("Invitees")
            
            <<< MultipleSelectorRow<String>() {
                $0.title = "Invitees"
                $0.options = DataManager.sharedInstance.defaultedInvitees
                    .map{ invitee -> String in
                        return invitee["name"] as? String ??  ""
                }
                let values : [String] = selectedSession.invitees
                    .map({ invitee -> String in
                        return invitee["name"] as? String ??  ""
                        
                    })
                
                let objectSet = Set(values.map { $0 })
                $0.value = objectSet
                
                }
        
        
        
    }
    
    
    
}
