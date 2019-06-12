//
//  BookDetailController.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit


class BookDetailController: knListController<QuoteCell, Quote> {
    var data: Book?
    let ui = UI()
    override func setupView() {
        addBackButton(tintColor: .c_main)
        navigationController?.fillNavigationBar(color: .white, titleColor: .c_main)
        navigationController?.removeLine()
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
        ui.coverImageView.downloadImage(from: data.cover)
    }
    
    func getData() {
        guard let bookId = data?.id else { return }
        GetQuotesWorker(bookId: bookId, successAction: { quotes in
            self.datasource = quotes
        }).execute()
//
//        datasource = [
//            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
//                  name: "Kono",
//                  content: "So many books, so little time.",
//                  timestamp: 1560248560),
//            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
//                  name: "Kono",
//                  content: "A room without books is like a body without a soul.",
//                  timestamp: 1560244560),
//            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
//                  name: "Kono",
//                  content: "The person, be it gentleman or lady, who has not pleasure in a good novel, must be intolerably stupid.",
//                  timestamp: 1560243560),
//            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
//                  name: "Kono",
//                  content: "Good friends, good books, and a sleepy conscience: this is the ideal life.",
//                  timestamp: 1560242560),
//            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
//                  name: "Kono",
//                  content: "Fairy tales are more than true: not because they tell us that dragons exist, but because they tell us that dragons can be beaten.",
//                  timestamp: 1510248560),
//            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
//                  name: "Kono",
//                  content: "Outside of a dog, a book is man's best friend. Inside of a dog it's too dark to read.",
//                  timestamp: 1563248560),
//            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
//                  name: "Kono",
//                  content: "I have always imagined that Paradise will be a kind of library.",
//                  timestamp: 1360248560),
//        ]
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
        quote.bookId = data?.id
        quote.content = ui.addQuoteView.textView.text
        AddQuoteWorker(quote: quote, successAction: {
            self.datasource.insert(quote, at: 0)
            self.ui.addQuoteView.dismiss()
            self.ui.addQuoteView.textView.text = ""
            button.setProcess(visible: false)
        }).execute()
    }
}
