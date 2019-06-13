//
//  FacebookLoginWorker.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/13/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookLoginWorker {
    weak var host: UIViewController?
    var permission: [String]
    private var successAction: ((Reader) -> Void)?
    private var failAction: ((knError) -> Void)?
    init(host: UIViewController,
         permission: [String],
         successAction: ((Reader) -> Void)?,
         failAction: ((knError) -> Void)?) {
        self.host = host
        self.permission = permission
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: permission, from: host!) {
            (result, error) in
            if let error = error {
                let err = knAuthError(message: error.localizedDescription)
                self.failAction?(err)
                return
            }
            
            guard let accessToken = AccessToken.current?.tokenString else {
                let err = knAuthError(message: "Can't get access token")
                self.failAction?(err)
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    let err = knAuthError(message: error.localizedDescription)
                    self.failAction?(err)
                    return
                }
                guard let user = user?.user else { return }
                self.didLoginSuccess(user: user)
            })
        }
    }
    
    private func didLoginSuccess(user: User) {
        let myself = Reader(user: user)
        DB().getCollection(.users)
            .document(myself.id)
            .setData(myself.toDict())
        appSetting.myId = myself.id
        appSetting.myself = myself
        successAction?(myself)
        
        if let url = myself.avatar {
            UIImageView.downloadImage(from: url, completion: { image in
                guard let image = image else { return }
                FileStorage()
                    .upload(image: image,
                            to: .users,
                            completion: { myUrl in
                                DB().getCollection(.users)
                                    .document(myself.id)
                                    .setData(["avatar": myUrl ?? url], merge: true)
                    })
            })
        }
    }
}
