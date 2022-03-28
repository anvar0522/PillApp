//
//  SetPilsTableViewController.swift
//  PillApp
//
//  Created by anvar on 13/03/22.
//

import UIKit
import RealmSwift

class SetPillsTableViewController: UIViewController {
   
     var delegate: PillsTableViewControllerDelegate!
//    var pills: PillList!

    
    @IBOutlet weak var datePickerLb: UIDatePicker!
    @IBOutlet weak var pillNameTF: UITextField!
    @IBOutlet weak var pillNoteTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

   
    @IBAction func savePill(_ sender: Any) {
         pillNameTF.text == ""
         ?   showAlert(title: "Oooops", message: "Пожалуйста введите название лекарства")
         :  saveTask(withName: pillNameTF.text ?? "", andnote: pillNoteTF.text ?? "")
        
        dismiss(animated: true)
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
    private func saveTask(withName name: String, andnote note: String){
        let pill = PillList(value: [name, note])
        StorageManager.shared.save(pill)
        
    }
        
    }
extension SetPillsTableViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
    
    extension SetPillsTableViewController {
        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.pillNameTF.text = ""
            }
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }





