//
//  RecordsViewController.swift
//  MAPD724-W2022-Assign4
//
//  Created by Walter Sancho on 15/03/2022.
//

import UIKit

class RecordsViewController: UITableViewController{
    private var records: [String]!
    private static let recordCell = "Record"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dummy tasks
        records = ["Clean car", "Do laundry"]
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // The Records List
            let cell = tableView.dequeueReusableCell(withIdentifier: "Record", for: indexPath) as! RecordCell
            
            cell.date?.text = "03/17/22"
            cell.totalKms?.text = "2.7"
            cell.totalTime?.text = "15:12"
            cell.averageSpeed?.text = "12.4"
        
            return cell
        }
    
}
