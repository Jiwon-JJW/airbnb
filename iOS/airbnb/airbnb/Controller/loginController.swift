//
//  loginController.swift
//  airbnb
//
//  Created by 심영민 on 2021/06/03.
//

import UIKit

class loginController: UIViewController {
    private var oauthManager: OAuthManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oauthManager = OAuthManager(parentViewController: self)
        oauthManager?.excuteOAuth()
    }
}
