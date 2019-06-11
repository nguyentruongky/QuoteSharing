//
//  Connector.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation
import Firebase

struct DB {
    enum FTable: String {
        case books
    }
    
    func getDocument(_ doc: FTable) {
        let db = Firestore.firestore()
        
        
    }
}
