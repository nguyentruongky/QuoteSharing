//
//  BookDetailController.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit


class BookDetailController: knListController<QuoteCell, Quote> {
    private var data: Book?
    let ui = UI()
    override func setupView() {
        addBackButton(tintColor: .c_main)
        navigationController?.hideBar(false)
        navigationController?.fillNavigationBar(color: .white, titleColor: .c_main)
        navigationController?.removeLine()
        contentInset = UIEdgeInsets(bottom: space)
        super.setupView()
        rowHeight = 150
        view.addSubviews(views: tableView)
        tableView.fillSuperView()
        tableView.backgroundColor = UIColor.c_secondary
        
        let headerView = ui.makeHeaderView()
        tableView.setHeader(headerView, height: 275)
        
        getData()
        ui.addQuoteButton.addTarget(self, action: #selector(addQuote))
        ui.addQuoteView.addButton.addTarget(self, action: #selector(saveQuote))
    }
    
    func setupData(_ data: Book) {
        self.data = data
        ui.authorLabel.text = data.author
        ui.titleLabel.text = data.title
        if data.cover == nil {
            ui.coverImageView.image = data.coverImage
        } else {
            ui.coverImageView.downloadImage(from: data.cover)
        }
    }
    
    func getData() {
        guard let bookId = data?.id else { return }
        GetQuotesWorker(bookId: bookId, successAction: { quotes in
            self.datasource = quotes
        }).execute()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ui.sectionHeaderView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 60 }
    
}

private extension BookDetailController {
    @objc func addQuote() {
        ui.addQuoteView.show(in: view, verticalSpace: -space * 3)
        ui.addQuoteView.textView.becomeFirstResponder()
    }
    
    @objc func saveQuote(button: UIButton) {
        button.setProcess(visible: true)
        var quote = Quote()
        quote.quoterId = appSetting.myId
        quote.bookId = data?.id
        quote.content = ui.addQuoteView.textView.text
        AddQuoteWorker(quote: quote, successAction: {
            self.datasource.insert(quote, at: 0)
            self.ui.addQuoteView.dismiss()
            self.ui.addQuoteView.textView.text = ""
            button.setProcess(visible: false)
        }).execute()
        
        guard let bookId = data?.id else { return }
        AddToMyReadingWorker(bookId: bookId).execute()
    }
}
