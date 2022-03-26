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
//         self.tableView.rowHeight = 80
        createTempData()
        
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
    
//    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
//        guard let navigationVC = segue.destination as? UINavigationController else {return}
//        guard let setPillsVC = navigationVC.topViewController as? SetPilsTableViewController else {return}
//        setPillsVC.pillList =
//        
//        
//        
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
