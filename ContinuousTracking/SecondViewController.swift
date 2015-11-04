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

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        Tracker.shared.delegate = self
        Tracker.shared.start()
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tracker.shared.stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
