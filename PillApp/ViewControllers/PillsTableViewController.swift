//
//  PillsTableViewController.swift
//  PillApp
//dsdsds
//  Created by anvar on 10/03/22.
//

import UIKit
import RealmSwift
import UserNotifications

class PillsTableViewController: UITableViewController {  
    private var pills: Results<PillList>!
    private var isEdit = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pills = StorageManager.shared.realm.objects(PillList.self)
        viewSettings()
        createTempData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          tableView.reloadData()
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController else { return }
        guard let setPill = navController.topViewController as? SetPillsTableViewController else { return }
        setPill.pill = sender as? PillList
    }
    
    @IBAction func unwind (for segue: UIStoryboardSegue) {
        guard let setPillVC = segue.source as? SetPillsTableViewController else { return }
        let pill = PillList(value: [setPillVC.pillNameTF.text ?? "ии",
                                    setPillVC.pillNoteTF.text ?? "ии",
                                    setPillVC.datePickerLb.text ?? "",
                                    setPillVC.datePicker.date
                                   ])
        
        if isEdit{
            StorageManager.shared.save(pill)
            setPillVC.notificationSent()
            setPillVC.showAlert(title: "Поздравляем!", message: "Уведомления будут приходить каждый день")
        } else {
            guard let index = tableView.indexPathForSelectedRow else { return }
            StorageManager.shared.edit(pills[index.row], newName: pill.name, newNote: pill.note, newTime: pill.time, newDate: pill.date)
            setPillVC.notificationSent()
}
        tableView.reloadData()
        }
    
    @IBAction func addPill(_ sender: Any) {
        isEdit = true
        performSegue(withIdentifier: "setPillVC", sender: nil)
        
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pills.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pillCell", for: indexPath) as! PillCell
        let pillList = pills[indexPath.row]
        cell.configure(with: pillList )
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isEdit = false
        let pill = pills[indexPath.row]
        performSegue(withIdentifier: "setPillVC", sender: pill)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let pillList = pills[indexPath.row]
        if editingStyle == .delete {
            StorageManager.shared.delete(pillList)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // MARK: - Private Methods
    private func viewSettings() {
        navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.style = .done
        editButtonItem.tintColor = UIColor(hexString: "293855", alpha: 2)
        self.tableView.rowHeight = UITableView.automaticDimension;
        
    }
    private func createTempData(){
        DataManager.shared.createTempData() {
            self.tableView.reloadData()
        }
    }
}
extension PillsTableViewController {
     func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true)
    }
}


