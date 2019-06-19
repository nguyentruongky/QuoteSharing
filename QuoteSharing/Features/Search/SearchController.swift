//
//  SearchController.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/14/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

class SearchController: GridController<BookCell, Book> {
    let stateView = knStateView()
    let addButton = UIMaker.makeMainButton(title: "Add")
    let searchTextField = UIMaker.makeTextField(placeholder: "Search")

    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }
    override func setupView() {
        columnSpacing = space
        lineSpacing = space
        contentInset = UIEdgeInsets(space: space)
        let width = screenWidth / 2 - 24 * 1.5
        itemSize = CGSize(width: width, height: width * 1.9)
        super.setupView()
        
        searchTextField.autocorrectionType = .no
        searchTextField.delegate = self
        searchTextField.setView(.left, space: 16)
        searchTextField.setCorner(radius: 22)
        searchTextField.setBorder(width: 1, color: .lightGray)
        searchTextField.height(44)
        searchTextField.horizontalSuperview()
        searchTextField.centerYSuperView()
        
        view.addSubviews(views: searchTextField, collectionView)
        view.stackVertically(views: [searchTextField, collectionView],
                             viewSpaces: 12, topSpace: 66, bottomSpace: 0)
        searchTextField.horizontalSuperview(space: space)
        collectionView.horizontalSuperview()
        
        getData()
        
        stateView.setStateContent(state: .empty,
                                  imageName: "no_books",
                                  title: "No books found",
                                  content: "Change your keyword or add your book")
        
        stateView.addSubview(addButton)
        addButton.centerYSuperView(space: 120)
        addButton.horizontalSuperview(space: space)
        addButton.addTarget(self, action: #selector(showAddBook))
    }
    
    @objc func showAddBook() {
        hideKeyboard()
        let controller = AddBookController()
        controller.delegate = self
        present(controller)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideBar(true)
        getData()
    }
    
    func getData() {
        GetMostReadBooks(successAction: { books in
            var source = books
            source.append(contentsOf: books)

            self.datasource = source
        }).execute()
    }
    
    override func didSelectItem(at indexPath: IndexPath) {
        hideKeyboard()
        let controller = BookDetailController()
        controller.setupData(datasource[indexPath.row])
        push(controller)
    }
}

extension SearchController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(startSearching), with: text, afterDelay: 0.35)
        return true
    }
    
    @objc func startSearching(keyword: String) {
        SearchBooksWorker(keyword: keyword, successAction: { [unowned self] books in
            self.datasource = books
            if books.isEmpty {
                self.stateView.show(state: .empty, in: self.collectionView, space: UIEdgeInsets(top: 120, bottom: 120))
            }
        }).execute()
    }
}

extension SearchController: AddBookDelegate {
    func didAddBook(_ book: Book) {
        let controller = BookDetailController()
        controller.setupData(book)
        push(controller)
    }
}

protocol AddBookDelegate: class {
    func didAddBook(_ book: Book)
}
