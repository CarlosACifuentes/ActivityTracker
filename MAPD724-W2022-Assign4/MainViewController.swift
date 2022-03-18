//
//  ViewController.swift
//  MAPD724-W2022-Assign4
//
//  Created by Walter Sancho on 11/03/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    
    private var locationManager = LocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.checkLocationAuthorization()
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

