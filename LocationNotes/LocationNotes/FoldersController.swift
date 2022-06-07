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
        LocationManager.sharedInstance.requestAuthorization()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToFolder", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFolder" {
            let selectedFolder = folders[tableView.indexPathForSelectedRow!.row]
            (segue.destination as! FolderController).folder = selectedFolder
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let folderInCell = folders[indexPath.row]
            CoreDataManager.sharedInstance.managetObjectContext.delete(folderInCell)
            
            CoreDataManager.sharedInstance.saveContext()
         // Delete the row
            tableView.deleteRows(at: [indexPath], with: .left)
        } else if editingStyle == .insert {
            
        }
    }
    
    

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
        cell.detailTextLabel?.text = "\(folderInCell.notes!.count) item(-s)"
        
        return cell
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Create new folder".localize(), message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (text) in
            text.placeholder = "Folder name".localize()
        }
        
        let alertActionAdd = UIAlertAction(title: "Create", style: UIAlertAction.Style.default) { (alert) in
            let folderName = alertController.textFields?[0].text
            if folderName != "" {
                _ = Folder.newFolder(name: folderName!.uppercased())
                CoreDataManager.sharedInstance.saveContext()
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
