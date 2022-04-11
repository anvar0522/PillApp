//
//  SetPilsTableViewController.swift
//  PillApp
//
//  Created by anvar on 13/03/22.
//

import UIKit
import UserNotifications
import RealmSwift

class SetPillsTableViewController: UIViewController {
    let requestId = ["pill1","pill2", "pill3","pill4","pill5","pill6","pill7","pill8","pill9","pill10",
                     "pill11","pill12","pill13","pill14","pill15","pill6","pill17","pill18","pill19","pill20",]
    
    var pill: PillList!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var datePickerLb: UILabel!
    @IBOutlet weak var pillNameTF: UITextField!
    @IBOutlet weak var pillNoteTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        addTargetForTF()
        datePicker.sendActions(for: .valueChanged)
        pillNameTF.becomeFirstResponder()
        
        if let pill = pill {
            pillNameTF.text = pill.name
            pillNoteTF.text = pill.note
            datePicker.date = pill.date
        }
}
    
    @objc private func setActivityForSaveButton() {

        let pillName = pillNameTF.text ?? ""
        
        saveButton.isEnabled = !pillName.isEmpty
    }
    
    private func addTargetForTF() {
        for textField in [datePicker, pillNameTF] {
            textField?.addTarget(
                self,
                action: #selector(setActivityForSaveButton),
                for: .editingChanged
            )
        }
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
    // MARK: - Methods
     func notificationSent() {
        let center = UNUserNotificationCenter.current()
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Пожалуйста примите таблетки"
        content.body = "\(pillNameTF.text ?? ""): \(pillNoteTF.text ?? "")"
        content.categoryIdentifier = "notifyAboutPill"
        content.userInfo = ["customdata":"fizzbuzz"]
        content.sound = UNNotificationSound.default
        
         let request = UNNotificationRequest(identifier: pill.id,
                                            content: content,
                                            trigger: trigger)
        center.removePendingNotificationRequests(withIdentifiers: [pill.id])
        center.add(request)
    }
}

extension SetPillsTableViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == pillNameTF {
            pillNoteTF.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
        return true
        }
    }

extension SetPillsTableViewController {
     func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true)
    }
}





