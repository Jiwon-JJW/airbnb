//
//  finalreservationController.swift
//  airbnb
//
//  Created by 박정하 on 2021/06/02.
//

import UIKit

class FinalReservationController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        let a = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        self.view.addGestureRecognizer(a)
    }
    
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func reservationConfirmation() {
        //예약 확정 포스트 날리기
    }
}
