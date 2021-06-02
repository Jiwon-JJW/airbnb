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
    @IBOutlet weak var mapCardCollectionView: UICollectionView!
    
    private var mapItems: [MKMapItem]?
    private var boundingRegion: MKCoordinateRegion?
    
    private let locationManager = CLLocationManager()
    
    private var mapCardDataSource: MapCardDataSource
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.mapCardDataSource = MapCardDataSource(searchResult: SearchResult(properties: []))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.mapCardDataSource = MapCardDataSource(searchResult: SearchResult(properties: []))
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.mapCardCollectionView.dataSource = mapCardDataSource
        mapView.showsUserLocation = true
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        goLocation(latitude: 37.484710, longtude: 127.033925, delta: 0.01)
        let customAnnotation = CustomAnnotation(title: "양재역", coordinate: CLLocationCoordinate2D(latitude: 37.484710, longitude: 127.033925))
        mapView.addAnnotation(customAnnotation)
    }
    
    func test(index: Int) {
        self.mapCardCollectionView.setContentOffset(CGPoint(x: self.mapCardCollectionView.frame.width * CGFloat(index), y: 0), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.mapCardCollectionView.reloadData()
    }
    
    func insert(searchResult: SearchResult) {
        self.mapCardDataSource.update(searchResult: searchResult)
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

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        var index = 0
        for i in 0..<mapView.annotations.count {
            if mapView.annotations[i] === view.annotation {
                index = i
                break
            }
        }
        test(index: index)
    }
}
