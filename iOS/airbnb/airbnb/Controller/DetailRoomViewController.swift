//
//  DetailRoomViewController.swift
//  airbnb
//
//  Created by 박정하 on 2021/06/02.
//

import UIKit

class DetailRoomViewController: UIViewController {
    
    private var roomDetailModel: RoomDetailModel
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.roomDetailModel = RoomDetailModel.empty
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.roomDetailModel = RoomDetailModel.empty
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showReservationWindow(_ sender: Any) {
        guard let reservation = storyboard?.instantiateViewController(identifier: "reservation") else { return }
        reservation.view.backgroundColor = UIColor(white: 0, alpha: 0)
        reservation.modalPresentationStyle = .custom
        self.present(reservation, animated: true, completion: nil)
    }
    
    func insert(roomDetailModel: RoomDetailModel) {
        self.roomDetailModel = roomDetailModel
        print(self.roomDetailModel.title)
    }
}
