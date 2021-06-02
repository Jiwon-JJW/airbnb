//
//  MapCardCell.swift
//  airbnb
//
//  Created by 심영민 on 2021/06/01.
//

import UIKit

class MapCardCell: UICollectionViewCell {
    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func update(imageUrl: String, rating: String, reviewCount: String, roomeName: String, price: String) {
        roomImageView.load(url: imageUrl)
        ratingLabel.text = rating
        reviewCountLabel.text = reviewCount
        roomNameLabel.text = roomeName
        priceLabel.text = price
    }
}
