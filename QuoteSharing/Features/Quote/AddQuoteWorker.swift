//
//  AddQuoteWorker.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/12/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation
struct AddQuoteWorker {
    var quote: Quote
    private var successAction: (() -> Void)?
    init(quote: Quote,
         successAction: (() -> Void)?) {
        self.quote = quote
        self.successAction = successAction
    }
    
    func execute() {
        DB().getCollection(.quotes)
            .document(quote.id)
            .setData(quote.toDict()) { (error) in
                self.successAction?()
        }
    }
}
