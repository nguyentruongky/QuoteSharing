//
//  GetBooksWorker.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation


class GetBooksWorker {
    private(set) var successAction: (([Book]) -> Void)?
    init(successAction: (([Book]) -> Void)?) {
        self.successAction = successAction
    }
    
    func execute() {
        DB().getCollection(.books)
            .getDocuments {(snapshot, error) in
                if let _ = error {
                    self.successAction?([])
                    return
                }
                
                guard let queryDoc = snapshot?.documents
                    .compactMap({ $0.data() as AnyObject }) else { return }
                // filter logic here
                let books = queryDoc.map({ Book(rawData: $0) })
                self.successAction?(books)
        }
    }
}

class GetMostReadBooks: GetBooksWorker {
    override func execute() {
        DB().getCollection(.books)
            .getDocuments {(snapshot, error) in
                if let _ = error {
                    self.successAction?([])
                    return
                }
                
                guard let queryDoc = snapshot?.documents
                    .compactMap({ $0.data() as AnyObject }) else { return }
                // filter logic here
                let books = queryDoc.map({ Book(rawData: $0) })
                self.successAction?(books)
        }
    }
}

class GetNewBooks: GetBooksWorker {
    override func execute() {
        DB().getCollection(.books)
            .getDocuments { (snapshot, error) in
                if let _ = error {
                    self.successAction?([])
                    return
                }
                
                guard let queryDoc = snapshot?.documents
                    .compactMap({ $0.data() as AnyObject }) else { return }
                // filter logic here
                let books = queryDoc.map({ Book(rawData: $0) })
                self.successAction?(books)
        }
    }
}

class GetReadingBooks: GetBooksWorker {
    override func execute() {
        DB().getCollection(.books)
            .getDocuments { (snapshot, error) in
                if let _ = error {
                    self.successAction?([])
                    return
                }
                
                guard let queryDoc = snapshot?.documents
                    .compactMap({ $0.data() as AnyObject }) else { return }
                // filter logic here
                let books = queryDoc.map({ Book(rawData: $0) })
                self.successAction?(books)
        }
    }
}
