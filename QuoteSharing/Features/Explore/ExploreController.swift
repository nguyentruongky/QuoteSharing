//
//  BookShelf.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
class ExploreController: knStaticListController {
    let ui = UI()
    
    override func setupView() {
        contentInset = UIEdgeInsets(top: hasNotch() ? -44 : 0)
        super.setupView()
        view.addSubview(tableView)
        tableView.top(toView: view)
        tableView.horizontalSuperview()
        tableView.bottomSuperView()

        
        navigationController?.hideBar(true)
        let headerView = ui.makeReadingView()
        tableView.setHeader(headerView, height: hasNotch() ? 304 : 200)
        ui.coverImageView.downloadImage(from: "https://images-na.ssl-images-amazon.com/images/I/41o0Fkf%2BvfL.jpg")
        
        getData()
        tableView.backgroundColor = UIColor(r: 241, g: 243, b: 245)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }
    var statusHidden = false { didSet { setNeedsStatusBarAppearanceUpdate() }}
    override var prefersStatusBarHidden: Bool {
        return statusHidden
    }
    func getData() {
        GetMostReadBooks { [unowned self] (datasource) in
            self.didGetDataSuccess(books: datasource, shelf: self.ui.mostReadBooksView)
        }.execute()
        
        GetNewBooks { [unowned self] (datasource) in
            self.didGetDataSuccess(books: datasource, shelf: self.ui.newBooksView)
        }.execute()
        
        GetReadingBooks { [unowned self] (datasource) in
            if datasource.isEmpty { return }
            let ui = self.ui
            ui.yourShelfView.datasource = datasource
            self.datasource.insert(ui.addShelf(ui.yourShelfView, shelfHeight: 400), at: 0)
            }.execute()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let hidden = scrollView.contentOffset.y > 0
        statusHidden = hidden
    }
}

private extension ExploreController {
    func didGetDataSuccess(books: [Book], shelf: BookShelfView) {
        if !books.isEmpty {
            shelf.datasource = books
            datasource.append(ui.addShelf(shelf, shelfHeight: 400))
        }
    }
}
