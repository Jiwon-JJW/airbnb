//
//  CustomAnnotaionView.swift
//  airbnb
//
//  Created by 심영민 on 2021/06/01.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation{
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        super.init()
    }
    
}

class CustomAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
      willSet {
        guard let custom = newValue as? CustomAnnotation else {
          return
        }
        canShowCallout = false
        frame = CGRect(x: 0, y: 0, width: 95, height: 28)
        backgroundColor = .white
        self.layer.cornerRadius = 10
        let label = UILabel()
        label.text = custom.title
        label.frame = frame
        label.textAlignment = .center
        self.addSubview(label)
        
//        let detailLabel = UILabel()
//        detailLabel.numberOfLines = 0
//        detailLabel.font = detailLabel.font.withSize(12)
//        detailLabel.text = custom.subtitle
//        detailCalloutAccessoryView = detailLabel
//
//        centerOffset = CGPoint(x: 0, y: 0)
//        canShowCallout = true
//        calloutOffset = CGPoint(x: -5, y: 5)
//        let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
//        mapsButton.setBackgroundImage(UIImage(systemName: "map"), for: .normal)
//        rightCalloutAccessoryView = mapsButton
      }
    }
}
