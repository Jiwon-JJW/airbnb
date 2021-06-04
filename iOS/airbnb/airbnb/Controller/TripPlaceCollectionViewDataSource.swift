//
//  NearLocationCollectionViewDataSource.swift
//  airbnb
//
//  Created by 박정하 on 2021/05/18.
//

import UIKit

class TripPlaceCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var tripPlace: [TripPlace]
    private var distance: [String] = ["차로 30분거리", "차로 1시간거리", "차로 3시간거리", "차로 4시간거리", "비행기로 1시간거리"]
    
    init(tripPlace: [TripPlace]) {
        self.tripPlace = tripPlace
    }
    
    func updateTripPlace(tripPlace: [TripPlace]) {
        self.tripPlace = tripPlace
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tripPlace.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripPlaceCollectionViewCell", for: indexPath) as? TripPlaceCollectionViewCell else {
            return TripPlaceCollectionViewCell()
        }
        
        cell.update(id: tripPlace[indexPath.row].id, name: tripPlace[indexPath.row].name, imageUrl: tripPlace[indexPath.row].imageUrl, distance: distance[indexPath.row])
        
        return cell
    }
}
