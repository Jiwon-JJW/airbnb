//
//  MapViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/05/31.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var mapItems: [MKMapItem]?
    var boundingRegion: MKCoordinateRegion?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        goLocation(latitude: 37.484710, longtude: 127.033925, delta: 0.01)
        let customAnnotation = CustomAnnotation(title: "양재역", coordinate: CLLocationCoordinate2D(latitude: 37.484710, longitude: 127.033925))
        mapView.addAnnotation(customAnnotation)
    }
    
    func goLocation(latitude: CLLocationDegrees,
                    longtude: CLLocationDegrees,
                    delta span: Double) -> CLLocationCoordinate2D {
        let location = CLLocationCoordinate2DMake(latitude, longtude)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let region = MKCoordinateRegion(center: location, span: spanValue)
        mapView.setRegion(region, animated: true)
        return location
    }
    
    func setAnnotation(latitude: CLLocationDegrees,
                       longtude: CLLocationDegrees,
                       delta span: Double,
                       title : String) -> MKPointAnnotation{
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitude: latitude, longtude: longtude, delta: span)
        annotation.title = title
        return annotation
    }
}
class CustomAnnotation: NSObject, MKAnnotation{
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let subtitle: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = "123,123원"
        super.init()
    }
}

class CustomMarkerAnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
      willSet {
        // 1
        guard let custom = newValue as? CustomAnnotation else {
          return
        }
        canShowCallout = true
        calloutOffset = CGPoint(x: -5, y: 5)
        rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
      }
    }
}
class CustomAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
      willSet {
        guard let custom = newValue as? CustomAnnotation else {
          return
        }
        
        frame = CGRect(x: 0, y: 0, width: 95, height: 28)
        backgroundColor = .white
        self.layer.cornerRadius = 10
        let label = UILabel()
        label.text = custom.subtitle
        label.frame = frame
        label.textAlignment = .center
        self.addSubview(label)
        
        let detailLabel = UILabel()
        detailLabel.numberOfLines = 0
        detailLabel.font = detailLabel.font.withSize(12)
        detailLabel.text = custom.subtitle
        detailCalloutAccessoryView = detailLabel
        
        centerOffset = CGPoint(x: 0, y: 0)
        canShowCallout = true
        calloutOffset = CGPoint(x: -5, y: 5)
        let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
        mapsButton.setBackgroundImage(UIImage(systemName: "map"), for: .normal)
        rightCalloutAccessoryView = mapsButton
      }
    }
}
