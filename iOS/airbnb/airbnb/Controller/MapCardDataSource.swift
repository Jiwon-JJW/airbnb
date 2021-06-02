//
//  MapViewDataSource.swift
//  airbnb
//
//  Created by 심영민 on 2021/06/01.
//

import UIKit
import MapKit

class MapCardDataSource: NSObject, UICollectionViewDataSource {
    
    private var searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.properties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCardCell", for: indexPath) as? MapCardCell else {
            return MapCardCell()
        }
        
        cell.update(imageUrl: searchResult.properties[indexPath.row].images,
                    rating: searchResult.properties[indexPath.row].ratingDescription,
                    reviewCount: searchResult.properties[indexPath.row].reviewCountDescription,
                    roomeName: searchResult.properties[indexPath.row].title,
                    price: searchResult.properties[indexPath.row].decimalWon(value: searchResult.properties[indexPath.row].priceDescription))
        return cell
    }
    
    func update(searchResult: SearchResult) {
        self.searchResult = searchResult
    }
    
//    func createCustomAnnotation() -> [CustomAnnotation] {
//        var annotations: [CustomAnnotation]
//
//        annotations = searchResult.properties.map { room in
//            CustomAnnotation(title: room.decimalWon(value: room.priceDescription), coordinate: CLLocationCoordinate2D(latitude: room.latitude, longitude: room.longitude))
//        }
//    }
// 이 함수를 mapViewController에서 호출해서 Annotations에 넣는다.
// mapView.annotations = createCustomAnnotation()
}
