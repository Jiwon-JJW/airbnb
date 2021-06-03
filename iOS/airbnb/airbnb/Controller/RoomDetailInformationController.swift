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
        let width = self.view.frame.width
        let height = width * (320 / 375)
        roomDetail.imageUrls.forEach { imageUrl in
            let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: height)))
//            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 375/320).isActive = true
            //imageView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 375/320).isActive = true
            imageView.load(url: imageUrl)
            

            if self.roomImageScrollView.subviews.last == nil {
                self.roomImageStackView.addSubview(imageView)
            } else {
                self.roomImageScrollView.subviews.last?.addSubview(imageView)
            }
            imageView.contentMode = .scaleToFill
            print(roomImageStackView.frame.width)
            print(roomImageScrollView.frame.width)
        }
    }
}
