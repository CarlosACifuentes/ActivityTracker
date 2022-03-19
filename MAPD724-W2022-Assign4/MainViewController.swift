//
//  ViewController.swift
//  MAPD724-W2022-Assign4
//
//  Created by Walter Sancho on 11/03/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    
    private var locationManager = LocationManager()
    private var userWeightTF = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.checkLocationAuthorization()
        
        // get user weight if not present
        let listItems = UserDefaults.standard
        let tempVal = listItems.string(forKey: "userWeight")
        if(tempVal == nil) {
            let alert = UIAlertController(title: "Please enter your Weight in kilograms", message: "You can modify it under settings", preferredStyle: .alert)
            alert.addTextField { (textField) in
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    self.userWeightTF = (alert?.textFields![0])! // Force unwrapping because we know it exists.
                    listItems.set(self.userWeightTF.text, forKey: "userWeight")
                    //  Save
                    listItems.synchronize()
                    print("Text field: \(String(describing: self.userWeightTF.text))")
                }))
            self.present(alert, animated: true, completion: nil)
            
            }
        }
    }
    
    @IBAction func onStartButtonClick(_ sender: UIButton) {
        // check authorization
        if locationManager.manager.authorizationStatus != .denied {
            self.performSegue(withIdentifier: "mapSegue", sender: self)
        }else{
            let confirmAlert = UIAlertController(title: "Authorization Error", message: "This app is not allowed to track your location. Modify location permissions in the settings.", preferredStyle: UIAlertController.Style.alert)

            confirmAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                }))
            self.present(confirmAlert, animated: true, completion: nil)
        }
    }
    

    @IBAction func onRecordsButtonClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "recordSegue", sender: self)
    }
    
    
    @IBAction func onSettingsButtonClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "settingSegue", sender: self)
    }
}

