//
//  UpdateProfileWorker.swift
//  Shopmate
//
//  Created by Ky Nguyen on 4/19/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation
struct UpdateProfileWorker {
    private let api = "/customer"
    var user: Reader
    var success: (() -> Void)?
    var fail: ((knError) -> Void)?
    init(user: Reader,
         success: (() -> Void)?,
         fail: ((knError) -> Void)?) {
        self.user = user
        self.success = success
        self.fail = fail
    }

    func execute() {
        
    }

    private func successResponse(returnData: AnyObject) {
        print(returnData)
        success?()
    }

    private func failResponse(_ err: knError) {
        print(err)
        success?()
    }
}
