//
//  ReadingController.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/17/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
class ReadingController: BookDetailController {
    private var data: Book?
    override func setupData(_ data: Book) {
        self.data = data
        title = data.title
    }
    
    override func setupView() {
        
    }
}


