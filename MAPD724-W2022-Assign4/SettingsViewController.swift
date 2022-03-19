//
//  SettingsViewController.swift
//  MAPD724-W2022-Assign4
//
//  Created by Walter Sancho on 17/03/2022.
//

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
            print("Text field: \(String(describing: tempVal))")
        }
    }
    
    @IBAction func onChangeWeightClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "Please enter your Weight in kilograms", message: "You can modify it under settings", preferredStyle: .alert)
        alert.addTextField { (textField) in
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                self.weightLabel.text = (alert?.textFields![0].text)! // Force unwrapping because we know it exists.
                self.listItems.set(self.weightLabel.text, forKey: "userWeight")
                //  Save
                self.listItems.synchronize()
                print("Text field: \(String(describing: self.weightLabel.text))")
            }))
        self.present(alert, animated: true, completion: nil)
        }
    }
}
