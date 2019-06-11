//
//  AddBooks.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
class AddBookController: knStaticListController {
    let ui = UI()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupView()
    }
    
    override func setupView() {
        super.setupView()
        title = "Add your reading book"
        view.addSubviews(views: tableView)
        tableView.fillSuperView()
        datasource = ui.setupView()
    }
}
