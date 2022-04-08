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
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
}
    
    @objc private func setActivityForSaveButton() {

        let pillName = pillNameTF.text ?? ""
//        let datePickerLB = datePickerLb.text ?? ""
        
        if pillName == "" {
            saveButton.isEnabled = false
        } else {
        saveButton.isEnabled = true
    }
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
    // MARK: - Private Methods
     func allowNotifications() {
        let center1 = UNUserNotificationCenter.current()
        center1.removeAllPendingNotificationRequests()
        
        center1.requestAuthorization(options: [.alert, .badge , .sound]) { granted, error in
            if granted {
                print ("Sent")
            } else {
                print("Error")
            }
        }
    }
     func notificationSent() {
        let center2 = UNUserNotificationCenter.current()
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Пожалуйста примите таблетки"
        content.body = "\(pillNameTF.text ?? "") \(pillNoteTF.text ?? "")"
        content.categoryIdentifier = "notifyAboutPill"
        content.userInfo = ["customdata":"fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center2.add(request)
    }
}
extension SetPillsTableViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension SetPillsTableViewController {
     func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}





