//
//  DetailRoomInformationController.swift
//  airbnb
//
//  Created by 심영민 on 2021/06/02.
//

import UIKit

class RoomDetailInformationController: UIViewController {
    
    @IBOutlet weak var roomImageScrollView: UIScrollView!
    @IBOutlet weak var roomImageStackView: UIStackView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var propertyLabel: UILabel!
    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var reservationButton: UIButton!
    @IBOutlet weak var hostImageView: UIImageView!
    @IBOutlet weak var roomImageView: UIImageView!
    
    private var roomDetail: RoomDetailModel
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.roomDetail = RoomDetailModel.empty
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.roomDetail = RoomDetailModel.empty
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func insert(roomDetail: RoomDetailModel) {
        self.roomDetail = roomDetail
        updateView()
    }
    
    func updateView() {
        
        addImageView()
        self.hostImageView.load(url: roomDetail.host.imageUrl)
        self.roomNameLabel.text = roomDetail.title
        self.ratingLabel.text = roomDetail.ratingDescription
        self.reviewCountLabel.text = roomDetail.reviewCountDescription
        self.locationLabel.text = roomDetail.locationName
        self.propertyLabel.text = roomDetail.propertyType
        self.hostNameLabel.text = roomDetail.host.name
        self.optionLabel.text = "\(roomDetail.maxOccupancyDesscription) • \(roomDetail.bedCountDescription) • \(roomDetail.bathCoutDescription)"
        self.descriptionLabel.text = roomDetail.description
    }
    
    func addImageView() {
        self.roomImageView.load(url: roomDetail.imageUrls[0])
        roomImageView.translatesAutoresizingMaskIntoConstraints = false
        roomImageView.widthAnchor.constraint(equalTo: self.roomImageView.widthAnchor).isActive = true
        roomImageView.heightAnchor.constraint(equalTo: self.roomImageView.heightAnchor).isActive = true
        self.roomImageStackView.addArrangedSubview(roomImageView)
        for index in 1..<roomDetail.imageUrls.count {
            let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: self.roomImageView.frame.width, height: self.roomImageView.frame.height)))
            imageView.load(url: roomDetail.imageUrls[index])
            self.roomImageStackView.addArrangedSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
//            imageView.widthAnchor.constraint(equalTo: self.roomImageView.widthAnchor).isActive = true
//            imageView.heightAnchor.constraint(equalTo: self.roomImageView.heightAnchor).isActive = true
            
        }
        
        //    roomDetail.imageUrls.forEach { imageUrl in
        //    }
    }
}
