//
//  LoginController.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/12/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit

class LoginController: knController {
    let facebookButton = UIMaker.makeMainButton(title: "Login with Facebook", bgColor: UIColor(r: 60, g: 90, b: 153), titleColor: .white)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func setupView() {
        navigationController?.hideBar(true)
        let text = "Save your favourite quotes"
        let textLabel = UIMaker.makeLabel(text: text, alignment: .center)
        
        let imageView = UIMaker.makeImageView(image: UIImage(named: "quote"),
                                              contentMode: .scaleAspectFit)
        view.addSubviews(views: imageView, facebookButton, textLabel)
        imageView.horizontalSuperview(space: space * 2)
        imageView.square()
        imageView.centerYSuperView(space: -100)
        
        textLabel.horizontalSuperview(space: space)
        textLabel.verticalSpacing(toView: imageView, space: -44)
        
        facebookButton.horizontalSuperview(space: space)
        facebookButton.bottomSuperView(space: -space * 3)
        
        facebookButton.addTarget(self, action: #selector(loginWithFacebook))
    }
}

private extension LoginController {
    @objc func loginWithFacebook() {
        FacebookLoginWorker(host: self,
                            permission: ["public_profile", "email"],
                            successAction: didLoginSuccess,
                            failAction: didLoginFail).execute()
    }
    
    func didLoginFail(err: knError) {
        MessageHub.showError(err.message ?? "Unable to login")
    }
    
    func didLoginSuccess(user: Reader) {
        let controller = BookShelfController()
        present(wrap(controller))
    }
}
