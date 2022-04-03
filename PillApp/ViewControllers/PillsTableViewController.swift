//
//  PillsTableViewController.swift
//  PillApp
//
//  Created by anvar on 10/03/22.
//

import UIKit
import RealmSwift

class PillsTableViewController: UITableViewController {  
    var pills: Results<PillList>!

    override func viewDidLoad() {
        super.viewDidLoad()
        pills = StorageManager.shared.realm.objects(PillList.self)
        self.tableView.rowHeight = UITableView.automaticDimension;
        navigationItem.leftBarButtonItem = editButtonItem

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
        let pill = pills[indexPath.row]
        performSegue(withIdentifier: "showAddPill", sender: pill)
        }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pillList = pills[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            StorageManager.shared.delete(pillList)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let setPills = segue.destination as? SetPillsTableViewController else { return }
        let pillList = pills[indexPath.row]
        setPills.pills = pillList
    }
    
    
    private func createTempData(){
        DataManager.shared.createTempData {
            self.tableView.reloadData()
        }
    }
}
