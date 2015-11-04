//
//  ViewController.swift
//  ContinuousTracking
//
//  Created by Romain Menke on 03/11/15.
//  Copyright © 2015 Romain Menke. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, TrackerDelegate {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        Tracker.shared.delegate = self
        Tracker.shared.start()
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tracker.shared.disconnect()
    }
    
    func speedUpdate(speed: CLLocationSpeed) {
    }
    
    func locationUpdate(location: CLLocation) {
        label.text = "la: \(location.coordinate.latitude) lo: \(location.coordinate.longitude)"
    }
    
    func noAuthorization() {
        print("put an alertcontroller to ask the user to give auth")
    }
}