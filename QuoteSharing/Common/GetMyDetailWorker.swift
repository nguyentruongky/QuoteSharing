//
//  GetMyDetailWorker.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/13/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth

struct GetMyDetailWorker {
    func execute() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        DB().getCollection(.users)
            .document(id)
            .getDocument { (snapshot, err) in
                guard let rawData = snapshot?.data() else { return }
                let myself = Reader(raw: rawData as AnyObject)
                appSetting.myself = myself
        }
    }
}
