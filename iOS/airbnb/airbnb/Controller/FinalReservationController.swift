//
//  finalreservationController.swift
//  airbnb
//
//  Created by 박정하 on 2021/06/02.
//

import UIKit

class FinalReservationController: UIViewController {
    
    @IBOutlet weak var pricePerDayTitle: UILabel!
    @IBOutlet weak var priceForDayLabel: UILabel!
    @IBOutlet weak var roomChargeLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var cleaningFee: UILabel!
    @IBOutlet weak var servicePriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    private var reservationModel: ReservationModel
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.reservationModel = ReservationModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.reservationModel = ReservationModel()
        super.init(coder: coder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        let a = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        self.view.addGestureRecognizer(a)
    }
    
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func insert(Entity: ReservationModel) {
        self.reservationModel = Entity
        self.updateLabel()
    }
    
    func updateLabel() {
        pricePerDayTitle.text = "\((self.reservationModel.priceForDays / 2).decimalWon()) / 박"
        priceForDayLabel.text = "\((self.reservationModel.priceForDays / 2).decimalWon()) X 2박"
        roomChargeLabel.text = self.reservationModel.priceForDays.decimalWon()
        taxLabel.text = self.reservationModel.tax.decimalWon()
        cleaningFee.text = self.reservationModel.cleaningFee.decimalWon()
        servicePriceLabel.text = self.reservationModel.serviceFee.decimalWon()
        totalPriceLabel.text = self.reservationModel.totalPrice.decimalWon()
    }
    @IBAction func finalReservation(_ sender: Any) {
        
        let request = RoomDetailAPIEndPoint.init(path: "/reservation/1", httpMethod: .post)
        
        Network.requestReservation(with: request, dataType: ReservationModel.self, totalPrice: self.reservationModel.totalPrice) { result in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(_):
                print("예약성공")
            }
        }
    }
}
