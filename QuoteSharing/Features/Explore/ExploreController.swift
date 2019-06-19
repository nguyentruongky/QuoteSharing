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
        contentInset = UIEdgeInsets(top: hasNotch() ? -44 : 0, bottom: space)
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
        tableView.backgroundColor = .clear
        view.backgroundColor = UIColor.white
        
        let stickView = UIMaker.makeView(background: UIColor.secondaryLight)
        view.insertSubview(stickView, at: 0)
        stickView.height(400)
        stickView.topSuperView()
        stickView.horizontalSuperview()
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
        
        GetStoriesWorker { [unowned self] (datasource) in
            self.didGetStories(datasource)
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
    
    func didGetStories(_ stories: [Story]) {
        if !stories.isEmpty {
            ui.storiesView.datasource = stories
            datasource.append(ui.addShelf(ui.storiesView, shelfHeight: 400))
        }
    }
}
