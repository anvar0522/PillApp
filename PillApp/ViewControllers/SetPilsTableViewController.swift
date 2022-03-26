//
//  SetPilsTableViewController.swift
//  PillApp
//
//  Created by anvar on 13/03/22.
//

import UIKit

class SetPilsTableViewController: UIViewController {
    var pillList: PillList!

    @IBOutlet weak var datePickerLb: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

   
    @IBAction func savePill(_ sender: Any) {
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func datePicker(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        
        let _ = dateFormatter.string(from: datePickerLb.date)

        }
        
    }


