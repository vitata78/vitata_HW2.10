//
//  ListTableViewController.swift
//  vitata_HW2.10
//
//  Created by Andrew on 6/19/20.
//  Copyright © 2020 APNET HQ LLC. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var records: [Record]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fillData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        cell.textLabel?.text = records?[indexPath.row].item
        
        return cell
    }
    
    @IBAction func refreshButton(_ sender: UIBarButtonItem) {
        fillData()
    }
    
    
    private func fillData() {
        NetworkManager.shared.getData { (data, success) in
            if(success)
            {
                self.records = data
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "detail" else { return }
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! DetailsViewController
            detailVC.record = records?[indexPath.row]
            
        }
    }
    

}
