//
//  DetailMapViewController.swift
//  airbnb
//
//  Created by 박정하 on 2021/05/31.
//

import Foundation
import MapKit

class DetailMapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
        let coordinateLocation = CLLocationCoordinate2DMake(CLLocationDegrees(37.484710), CLLocationDegrees(127.033925))
        let spanValue = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let location = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        self.mapView.setRegion(location, animated: true)
    }
    
    
}
