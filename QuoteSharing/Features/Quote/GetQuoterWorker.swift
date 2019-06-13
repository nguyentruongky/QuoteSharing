//
//  GetQuoterWorker.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/13/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth

struct GetQuoterWorker {
    var quoterId: String
    private var successAction: ((Reader) -> Void)?
    init(quoterId: String, successAction: ((Reader) -> Void)?) {
        self.quoterId = quoterId
        self.successAction = successAction
    }
    func execute() {
        DB().getCollection(.users)
            .document(quoterId)
            .getDocument { (snapshot, err) in
                guard let rawData = snapshot?.data() else { return }
                let quoter = Reader(raw: rawData as AnyObject)
                self.successAction?(quoter)
        }
    }
}
