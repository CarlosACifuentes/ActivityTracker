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
import Firebase
import FirebaseDatabase

class RecordsViewController: UITableViewController
{
    private var records: [String]!
    private static let recordCell = "Record"
    var table = [Runs]()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("Runs")
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0 {
                self.table.removeAll()
                
                for run in snapshot.children.allObjects as! [DataSnapshot]
                {
                    let Object = run.value as? [String: AnyObject]
                    let id = Object?["id"]
                    let date = Object?["date"]
                    let time = Object?["duration"]
                    let distance = Object?["distance"]
                    let velocity = Object?["velocity"]
                    let calories = Object?["calories"]
                    
                    let run = Runs(
                        id: id as! String?,
                        date: date as! String?,
                        time: time as! String?,
                        distance: distance as! String?,
                        velocity: velocity as! String?,
                        calories: calories as! String?
                    )
                    self.table.append(run)
                    self.tableView.reloadData()
                }
            }
            
            
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.count
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
        }
    
    //function to show the records in the table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // The Records List
            let cell = tableView.dequeueReusableCell(withIdentifier: "Record", for: indexPath) as! RecordCell
        
        let run: Runs
        run = table[indexPath.row]
            
        cell.date?.text = run.date
        cell.totalKms?.text = run.distance
        cell.totalTime?.text = run.time
        cell.averageSpeed?.text = run.velocity
        
            return cell
        }

    
}
