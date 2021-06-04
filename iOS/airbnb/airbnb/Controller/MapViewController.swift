//
//  MapViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/05/31.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapCardCollectionView: UICollectionView!
    
    private var mapItems: [MKMapItem]?
    private var boundingRegion: MKCoordinateRegion?
    
    private let locationManager = CLLocationManager()
    
    private var searchResult: SearchResult
    private var mapCardDataSource: MapCardDataSource
    private var customAnnotations: [CustomAnnotation]
    private var selectedRoomId: Int = 0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.searchResult = SearchResult(properties: [])
        self.mapCardDataSource = MapCardDataSource(searchResult: searchResult)
        self.customAnnotations = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.searchResult = SearchResult(properties: [])
        self.mapCardDataSource = MapCardDataSource(searchResult: searchResult)
        self.customAnnotations = []
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
        self.mapCardCollectionView.delegate = self
        mapView.showsUserLocation = true
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        goLocation(latitude: 37.53364, longtude: 126.98, delta: 0.17)
        self.customAnnotations = createCustomAnnotation()
        mapView.addAnnotations(customAnnotations)
    }
    
    func test(index: Int) {
        self.mapCardCollectionView.setContentOffset(CGPoint(x: self.mapCardCollectionView.frame.width * CGFloat(index), y: 0), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.mapCardCollectionView.reloadData()
    }
    
    func insert(searchResult: SearchResult) {
        self.searchResult = searchResult
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
    
    func createCustomAnnotation() -> [CustomAnnotation] {
        var annotations: [CustomAnnotation]
        annotations = searchResult.properties.map { room in
            CustomAnnotation(title: room.pricePerNight.decimalWon(), coordinate: CLLocationCoordinate2D(latitude: room.latitude, longitude: room.longitude))
        }
        return annotations
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedRoomId = indexPath.row + 1
        self.performSegue(withIdentifier: "RoomDetailInformationController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let nextViewController = segue.destination as? RoomDetailInformationController else {
            return
        }
        self.requestRoomDetail(roomId: selectedRoomId, nextViewController: nextViewController)
    }
    
    func requestRoomDetail(roomId: Int, nextViewController: RoomDetailInformationController) {
        let networkManager = Network()
        let requestURL = MainAPIEndPoint.init(path: "/rooms/\(roomId)", httpMethod: .get)
        
        networkManager.request(with: requestURL, dataType: RoomDetailModel.self) { result in
            switch result {
            case .success(let data):
                nextViewController.insert(roomDetail: data, index: self.selectedRoomId)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        var index = 0
        for i in 0..<customAnnotations.count {
            if customAnnotations[i] === view.annotation {
                index = i
                break
            }
        }
        test(index: index)
    }
}
