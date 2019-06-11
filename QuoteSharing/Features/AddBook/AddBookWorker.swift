//
//  AddBookWorker.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import Foundation


struct AddBookWorker {
    var book: Book
    var success: (() -> Void)?
    var fail: ((knError) -> Void)?
    
    init(book: Book,
         success: (() -> Void)?,
         fail: ((knError) -> Void)?) {
        self.book = book
        self.success = success
        self.fail = fail
    }
    
    func execute() {
        let id = book.id
        DB().getCollection(.books)
            .document(id)
            .setData(book.toDict())
        if let cover = book.coverImage {
            FileStorage().upload(image: cover,
                                 to: .books,
                                 completion: { url in
                                    guard let url = url else { return }
                                    DB().getCollection(.books)
                                        .document(id)
                                        .updateData(["cover": url])
                                    self.success?()
            })
        }
    }
}
