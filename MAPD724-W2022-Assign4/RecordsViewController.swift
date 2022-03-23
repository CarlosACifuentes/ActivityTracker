/*
App        : Assignment 2 - Frameworks App
Version    : Part1
--------------------------
 Group #10
--------------------------
Author     : Walter Edgardo Sancho
Student ID : 301202813
--------------------------
Author     : Carlos Cifuentes
Student ID : 301140805
--------------------------
Date       : 03/25/2022 - Part 1
--------------------------
*/

import UIKit

class RecordsViewController: UITableViewController{
    private var records: [String]!
    private static let recordCell = "Record"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    //function to show the records in the table view
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
