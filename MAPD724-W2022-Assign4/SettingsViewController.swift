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

class SettingsViewController: UIViewController{
    

    @IBOutlet weak var weightLabel: UILabel!
    let listItems = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get user weight if not present
        let tempVal = listItems.string(forKey: "userWeight")
        if(tempVal != nil) {
            self.weightLabel.text = tempVal
        }
    }
    
    // function to change weight of the user under settings
    @IBAction func onChangeWeightClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "Please enter your Weight in kilograms", message: "You can modify it under settings", preferredStyle: .alert)
        alert.addTextField { (textField) in
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                
                if(alert?.textFields![0].text?.isEmpty == false)
                {
                    self.weightLabel.text = (alert?.textFields![0].text)! // Force unwrapping because we know it exists.
               
                    self.listItems.set(self.weightLabel.text, forKey: "userWeight")
                    //  Save
                    self.listItems.synchronize()
                }
            }))
        self.present(alert, animated: true, completion: nil)
        }
    }
}
