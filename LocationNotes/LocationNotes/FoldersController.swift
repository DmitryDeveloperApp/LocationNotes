//
//  FoldersController.swift
//  LocationNotes
//
//  Created by Dmitry Suprun on 31.05.2022.
//

import UIKit

class FoldersController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return folders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellFolder", for: indexPath)
        
        let folderInCell = folders[indexPath.row]
        
        cell.textLabel?.text = folderInCell.name
        
        return cell
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Create new folder", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (text) in
            text.placeholder = "Folder name"
        }
        
        let alertActionAdd = UIAlertAction(title: "Create", style: UIAlertAction.Style.default) { (alert) in
            let folderName = alertController.textFields?[0].text
            if folderName != "" {
                _ = Folder.newFolder(name: folderName!)
                self.tableView.reloadData()
            }
        }
         
        let alertActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (alert) in
            
        }
        
        alertController.addAction(alertActionAdd)
        alertController.addAction(alertActionCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
