//
//  ListTableViewController.swift
//  vitata_HW2.10
//
//  Created by Andrew on 6/19/20.
//  Copyright © 2020 APNET HQ LLC. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    var test: String!
    
    var records: [Record]!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        records = NetworkManager.shared.data
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        cell.textLabel?.text = records[indexPath.row].item
        
        return cell
    }
    
    @IBAction func refreshButton(_ sender: UIBarButtonItem) {
        NetworkManager.shared.getData()
        records = NetworkManager.shared.data
        tableView.reloadData()
        //print(output)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "detail" else { return }
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! DetailsViewController
            detailVC.record = records[indexPath.row]
            
        }
    }
    

}

extension ListTableViewController {
    
//    func processData(source: Feed) -> [Record] {
//        var output: [Record] = []
//        
//        for entryItem in 0..<(source.feed?.entry?.count ?? 0) {
//            
//            if source.feed?.entry?[entryItem].gs$cell?.col == "1" && source.feed?.entry?[entryItem].gs$cell?.row != "1" {
//                
//                var description: String = ""
//                var image: String = ""
//                
//                for entryDesc in 0..<(source.feed?.entry?.count ?? 0) {
//                    
//                    if source.feed?.entry?[entryDesc].gs$cell?.row == source.feed?.entry?[entryItem].gs$cell?.row && source.feed?.entry?[entryDesc].gs$cell?.col == "2" {
//                        description = source.feed?.entry?[entryDesc].gs$cell?.inputValue ?? ""
//                        
//                    }
//                    
//                    if source.feed?.entry?[entryDesc].gs$cell?.row == source.feed?.entry?[entryItem].gs$cell?.row && source.feed?.entry?[entryDesc].gs$cell?.col == "3" {
//                        image = source.feed?.entry?[entryDesc].gs$cell?.inputValue ?? ""
//                        
//                    }
//                    
//                }
//                
//                let item: String = source.feed?.entry?[entryItem].gs$cell?.inputValue ?? ""
//                
//                let record = Record(item: item, description: description, image: image)
//                
//                output.append(record)
//            }
//            
//        }
//        return output
//    }
    
    
}
