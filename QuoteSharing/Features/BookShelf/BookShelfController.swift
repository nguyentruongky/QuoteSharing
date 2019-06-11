//
//  BookShelf.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
class BookShelfController: knStaticListController {
    let ui = UI()
    
    override func setupView() {
        super.setupView()
        view.addSubview(tableView)
        tableView.fillSuperView()
        getData()
    }
    
    func getData() {
        GetMostReadBooks { [unowned self] (datasource) in
            self.didGetDataSuccess(books: datasource, shelf: self.ui.mostReadBooksView)
        }.execute()
        
        GetNewBooks { [unowned self] (datasource) in
            self.didGetDataSuccess(books: datasource, shelf: self.ui.newBooksView)
        }.execute()
    }
}

private extension BookShelfController {
    func didGetDataSuccess(books: [Book], shelf: BookShelfView) {
        if !books.isEmpty {
            shelf.datasource = books
            datasource.append(ui.addShelf(shelf, shelfHeight: 400))
        }
    }
}
