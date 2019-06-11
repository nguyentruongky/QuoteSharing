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
        
        registerEvents()
    }
}

private extension AddBookController {
    func registerEvents() {
        ui.addButton.addTarget(self, action: #selector(saveBook))
        ui.selectPhotoButton.addTarget(self, action: #selector(selectPhoto))
    }
}

extension AddBookController {
    @objc func saveBook() {
        let book = Book()
        book.title = ui.titleTextField.text
        book.author = ui.authorTextField.text
        book.coverImage = ui.coverImageView.image
        AddBookWorker(book: book, success: { _ in
            
        }, fail: { error in
            
        }).execute()
    }
    
    @objc func selectPhoto() {
        knPhotoSelectorWorker(finishSelection: { [weak self] image in
            self?.ui.coverImageView.image = image
        }).execute()
    }
}
