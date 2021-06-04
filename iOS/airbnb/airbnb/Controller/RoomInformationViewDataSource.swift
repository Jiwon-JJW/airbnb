//
//  RoomInformationViewDataSource.swift
//  airbnb
//
//  Created by 심영민 on 2021/05/24.
//

import UIKit

class RoomInformationViewDataSource: NSObject, UICollectionViewDataSource {

    private (set) var searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.properties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomInformationCell", for: indexPath) as? RoomInformationCell else {
            return RoomInformationCell()
        }
        cell.update(imageUrl: searchResult.properties[indexPath.row].images,
                    rating: searchResult.properties[indexPath.row].ratingDescription,
                    reviewCount: searchResult.properties[indexPath.row].reviewCountDescription,
                    roomName: searchResult.properties[indexPath.row].title,
                    price: searchResult.properties[indexPath.row].priceDescription,
                    totalPrice: searchResult.properties[indexPath.row].totalPriceDescription)

        return cell
    }
    
    func update(searchResult: SearchResult){
        self.searchResult = searchResult
    }
}

extension RoomInformationViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RoomInformationHeader", for: indexPath)
        return headerView
    }
}
