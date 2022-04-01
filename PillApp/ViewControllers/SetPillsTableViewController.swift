//
//  SetPilsTableViewController.swift
//  PillApp
//
//  Created by anvar on 13/03/22.
//

import UIKit
import RealmSwift

class SetPillsTableViewController: UIViewController {
   
  
    var pills: PillList!

    
    @IBOutlet weak var datePickerLb: UILabel!
    
    @IBOutlet weak var pillNameTF: UITextField!
    @IBOutlet weak var pillNoteTF: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
            }

   
    @IBAction func savePill(_ sender: Any) {
         pillNameTF.text == ""
         ?  showAlert(title: "Oooops", message: "Пожалуйста введите название лекарства")
         :  saveTask(withName: pillNameTF.text ?? "", andnote: pillNoteTF.text ?? "" , andtime: datePickerLb.text ?? "")
        
        dismiss(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
  
    @IBAction func datePickerChanged(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "HH:mm"
  
        let strDate = dateFormatter.string(from: datePicker.date)
        datePickerLb.text = strDate

        }
    private func saveTask(withName name: String, andnote note: String, andtime time: String){
        let pill = PillList(value: [name, note, time])
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





