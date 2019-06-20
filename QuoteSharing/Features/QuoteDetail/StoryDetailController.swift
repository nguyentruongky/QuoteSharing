//
//  QuoteDetailController.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/20/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

class StoryDetailController: knListController<CommentCell, Comment> {
    let ui = UI()
    lazy var headerView = ui.makeHeaderView()

    private var story: Story?
    func setData(_ data: Story) {
        self.story = data
        ui.contentLabel.text = data.quoteContent
        tableView.setHeader(headerView, height: 0)
        headerView.backgroundColor = .secondaryLight
    }
    
    override func setupView() {
        super.setupView()
        addBackButton(tintColor: .main)
        navigationController?.hideBar(false)
        setNavBarTitle(text: story?.bookTitle ?? "", font: .main(.bold), color: .main )
        
        view.addSubview(tableView)
        tableView.fillSuperView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let height = headerView.frame.height
        tableView.tableHeaderView = nil
        tableView.setHeader(headerView, height: height)
        headerView.layoutIfNeeded()
        
        datasource = [
            Comment(),
            Comment(),
            Comment(),
        ]
    }
}
