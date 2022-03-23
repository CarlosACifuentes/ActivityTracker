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

class MainViewController: UIViewController
{
    
    private var locationManager = LocationManager()
    private var userWeightTF = UITextField()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        locationManager.checkLocationAuthorization()
    }
    
    //function to handle the start button click
    @IBAction func onStartButtonClick(_ sender: UIButton)
    {
       
        // check authorization
        if locationManager.manager.authorizationStatus != .denied
        {
            validateWeightInput()
        }
        else
        {
            let confirmAlert = UIAlertController(title: "Authorization Error", message: "This app is not allowed to track your location. Modify location permissions in the settings.", preferredStyle: UIAlertController.Style.alert)

            confirmAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                }))
            self.present(confirmAlert, animated: true, completion: nil)
        }
    }
    
    //function to handle the records button click
    @IBAction func onRecordsButtonClick(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "recordSegue", sender: self)
    }
    
    //function to handle the setttings button click
    @IBAction func onSettingsButtonClick(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "settingSegue", sender: self)
    }
    
    //function to ensure user's weight is available to calculate calories later on.
    private func validateWeightInput()
    {
        let listItems = UserDefaults.standard
        let tempVal = listItems.string(forKey: "userWeight")
        if(tempVal == nil)
        {
            let alert = UIAlertController(title: "Please enter your Weight in kilograms", message: "You can modify it under settings", preferredStyle: .alert)
            alert.addTextField
            {
                (textField) in
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{[weak alert] (_) in
                        self.userWeightTF = (alert?.textFields![0])! // Force unwrapping because we know it exists.
                        listItems.set(self.userWeightTF.text, forKey: "userWeight")
                        //  Save
                        listItems.synchronize()
                    //send user to the Map Screen.
                    self.performSegue(withIdentifier: "mapSegue", sender: self)
            }))
                
            self.present(alert, animated: true, completion: nil)
            
            }
        }
    }
    
}

