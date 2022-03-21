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

// RecordCell variables for the table view
class RecordCell: UITableViewCell {
    @IBOutlet var date : UILabel?
    @IBOutlet var totalKms : UILabel?
    @IBOutlet var totalTime : UILabel?
    @IBOutlet var averageSpeed : UILabel?
}
