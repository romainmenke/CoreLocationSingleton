//
//  ViewController.swift
//  ContinuousTracking
//
//  Created by Romain Menke on 03/11/15.
//  Copyright © 2015 Romain Menke. All rights reserved.
//


// set sim to bycicle ride or drive or...

import UIKit
import CoreLocation

class ViewController: UIViewController, TrackerDelegate {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tracker.shared.start()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        Tracker.shared.delegate = self
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tracker.shared.disconnect()
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