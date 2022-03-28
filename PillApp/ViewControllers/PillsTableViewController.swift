//
//  PillsTableViewController.swift
//  PillApp
//
//  Created by anvar on 10/03/22.
//

import UIKit
import RealmSwift

protocol PillsTableViewControllerDelegate {
    func setNewValues(for pills: PillList)
}

class PillsTableViewController: UITableViewController, PillsTableViewControllerDelegate {
    func setNewValues(for pills: PillList) {
        
    }
    
  
    var pills: Results<PillList>!

    override func viewDidLoad() {
        super.viewDidLoad()
        pills = StorageManager.shared.realm.objects(PillList.self)
        self.tableView.rowHeight = UITableView.automaticDimension;
   
        createTempData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
            tableView.deselectRow(at: indexPath, animated: true)
        }
    
    private func createTempData(){
        DataManager.shared.createTempData {
            self.tableView.reloadData()
        }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let pillsVC = navigationVC.topViewController as? SetPillsTableViewController else { return }
        pillsVC.delegate = self
    }
}

// Пробовал через простой препейр, одно и тоже
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    guard let indexPath = tableView.indexPathForSelectedRow else { return }
//    guard let navigationVC = segue.destination as? UINavigationController else { return }
//    guard let pillsVC = navigationVC.topViewController as? SetPillsTableViewController else { return }
//
//    let pillList = pills[indexPath.row]
//    pillsVC.pills = pillList
//
//}
