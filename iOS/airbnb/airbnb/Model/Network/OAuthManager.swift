//
//  OAuthManager.swift
//  airbnb
//
//  Created by 박정하 on 2021/05/31.
//

import UIKit
import AuthenticationServices

class OAuthManager: NSObject, ASWebAuthenticationPresentationContextProviding {

    private var parentViewController: UIViewController
    
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return parentViewController.view.window ?? ASPresentationAnchor()
    }
    
    func excuteOAuth() {
        var webAuthSession: ASWebAuthenticationSession?

        let callbackUrlScheme = "airbnb"
        let url = URL.init(string: "https://github.com/login/oauth/authorize?client_id=f6663a82fa21bb12c810")
        
        webAuthSession = ASWebAuthenticationSession.init(url: url!, callbackURLScheme: callbackUrlScheme, completionHandler: { (callBack:URL?, error:Error?) in
            //             handle auth response
            guard error == nil, let successURL = callBack else {
                return
            }
            
            let oauthToken = NSURLComponents(string: (successURL.absoluteString))?.queryItems?.filter({$0.name == "code"}).first

            let tempstring: String = "\(oauthToken!)"
            print(tempstring)
            let urlurl: URL = URL(string: "http://13.124.136.233:8080/oauth/github/callback?\(tempstring)")!
            var request: URLRequest = URLRequest.init(url: urlurl)

            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { data, response, error in
                print(String(data: data!, encoding: String.Encoding.utf8))
            }.resume()
        })

        // Kick it off
        webAuthSession?.presentationContextProvider = self
        webAuthSession?.start()
    }
}
