//
//  LocationManager.swift
//  MRTJ
//
//  Created by Febrian Daniel on 23/07/23.
//

import Foundation
import CoreLocation
import MapKit
import UserNotifications

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    var notificationHandler = NotificationHandler()
    
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
    }
    
    func startMonitoring(center: CLLocationCoordinate2D, identifier: String) {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let geofenceRegion = CLCircularRegion(center: center, radius: 500, identifier: identifier)
            
            geofenceRegion.notifyOnEntry = true
            geofenceRegion.notifyOnExit = true
            
            locationManager.startMonitoring(for: geofenceRegion)
        }
    }
    
    func calculateNearestRegion(userLocation: CLLocation, regions: [CLCircularRegion]) -> (region: CLCircularRegion, distance: CLLocationDistance)? {
        var nearestRegion: CLCircularRegion?
        var nearestDistance: CLLocationDistance = Double.infinity
        
        for region in regions {
            let regionLocation = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
            let distance = userLocation.distance(from: regionLocation)
            
            if distance < nearestDistance {
                nearestRegion = region
                nearestDistance = distance
            }
        }
        if let closestRegion = nearestRegion {
            return (region: closestRegion, distance: nearestDistance)
        } else {
            return nil
        }
    }
    
    func checkRegionState(region: CLRegion) {
        locationManager.requestState(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            print("Entering \(region.identifier)")
            notificationHandler.handleEnterEvent(forRegion: region)
            notificationHandler.handleRegionBasedEvent(forRegion: region)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            print("Exiting \(region.identifier)")
            notificationHandler.handleExitEvent(forRegion: region)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch state {
        case .inside:
            notificationHandler.handleEnterEvent(forRegion: region)
        case .unknown:
            break
        case .outside:
            break
        }
    }
}
