//
//  SecondViewController.swift
//  ContinuousTracking
//
//  Created by Romain Menke on 04/11/15.
//  Copyright © 2015 Romain Menke. All rights reserved.
//

import UIKit
import CoreLocation

class SecondViewController: UIViewController, TrackerDelegate {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Tracker.shared.delegate = self
        
        label.text = "\(Tracker.shared.currentSpeed)"

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tracker.shared.disconnect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func speedUpdate(speed: CLLocationSpeed) {
        label.text = "\(speed)"
    }
    
    func locationUpdate(location: CLLocation) {
        
    }

    
    func noAuthorization() {
        print("put an alertcontroller to ask the user to give auth")
    }


}
