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
    
    var pills: PillList?
    
    
    @IBOutlet weak var datePickerLb: UILabel!
    @IBOutlet weak var pillNameTF: UITextField!
    @IBOutlet weak var pillNoteTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func savePill(_ sender: Any) {
        if pillNameTF.text == "" {
            showAlert(title: "Oooops", message: "Пожалуйста введите название лекарства")
        }else if  datePickerLb.text == "label" {
            showAlert(title: "Oooops", message: "Пожалуйста введите корректное время")
        } else {
            saveTask(withName: pillNameTF.text ?? "", andnote: pillNoteTF.text ?? "" , andtime: datePickerLb.text ?? "")
            dismiss(animated: true)
            allowNotifications()
            notificationSent()
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
    private func saveTask(withName name: String, andnote note: String, andtime time: String){
        let pill = PillList(value: [name, note, time])
        StorageManager.shared.save(pill)
    }
    private func allowNotifications() {
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
    private func notificationSent() {
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
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.pillNameTF.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}





