//
//  Connector.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum Node: String {
    case books, quotes
}

struct DB {
    func getCollection(_ doc: Node) -> CollectionReference {
        return Firestore.firestore().collection(doc.rawValue)
    }
}
