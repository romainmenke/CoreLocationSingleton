//
//  SharedLocationManager.swift
//  ContinuousTracking
//
//  Created by Romain Menke on 03/11/15.
//  Copyright © 2015 Romain Menke. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Tracker: NSObject, CLLocationManagerDelegate {
    
    static var shared = Tracker()

    private var manager = CLLocationManager()
    private var timer = NSTimer()
    private var authorized : Bool = false
    
    private var running : Bool = false
    private var shouldStart : Bool = false
    
    var region : MKCoordinateRegion?
    var currentSpeed: CLLocationSpeed = CLLocationSpeed()
    
    weak var delegate : TrackerDelegate?
    
    private override init() {
        super.init()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedAlways : authorized = true
        case .AuthorizedWhenInUse : authorized = true
        default :
            authorized = false
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .AuthorizedAlways : authorized = true
        case .AuthorizedWhenInUse : authorized = true
        default :
            guard let del = self.delegate else {
                return
            }
            del.noAuthorization()
        }
        
        // auth changed, start if all is good
        if shouldStart && authorized {
            startTimer()
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        manager.stopUpdatingLocation()
        
        let userLocation: CLLocation = locations[0] as CLLocation
        let coordinates2D = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        region = MKCoordinateRegion(center: coordinates2D, span: span)
        
        currentSpeed = userLocation.speed
        
        guard let del = delegate else {
            return
        }
        
        del.locationUpdate(userLocation)
        del.speedUpdate(currentSpeed)
    }
    
    func start() {
        // is auth just start
        if authorized {
            startTimer()
            return
        }
        
        // else see if it needs auth or if auth wasn't checked yet.
        switch CLLocationManager.authorizationStatus() {
        case .NotDetermined : manager.requestWhenInUseAuthorization()
        case .AuthorizedAlways :
            authorized = true
            startTimer()
            return
        case .AuthorizedWhenInUse :
            authorized = true
            startTimer()
            return
        default :
            // if there is no auth tell the VC
            guard let del = self.delegate else {
                return
            }
            del.noAuthorization()
        }
        
        // if start was called from a VC but it did not already start, set shouldStart to true
        shouldStart = true
    }
    
    private func startTimer() {
        // prevent double start
        if running {
            return
        } else {
            running = true
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("loopUpdate"), userInfo: nil, repeats: true)
    }
    
    func stop() {
        running = false
        shouldStart = false
        timer.invalidate()
    }
    
    
    internal func loopUpdate() {
        manager.startUpdatingLocation()
    }
}


protocol TrackerDelegate : class {
    
    func speedUpdate(speed:CLLocationSpeed)
    
    func locationUpdate(location:CLLocation)
    
    func noAuthorization()
    
}
