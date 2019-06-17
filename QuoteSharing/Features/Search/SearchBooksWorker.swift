//
//  SearchBooksWorker.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/14/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation
struct SearchBooksWorker {
    private var keyword: String
    private var successAction: (([Book]) -> Void)?
    init(keyword: String, successAction: (([Book]) -> Void)?) {
        self.keyword = keyword.lowercased()
        self.successAction = successAction
    }
    
    func execute() {
        GetBooksWorker(successAction: { books in
            self.didGetBooks(books: books)
        }).execute()
    }
    
    private func didGetBooks(books: [Book]) {
        let data = books.filter({ return $0.title?.lowercased().contains(keyword) == true })
        successAction?(data)
    }
}
