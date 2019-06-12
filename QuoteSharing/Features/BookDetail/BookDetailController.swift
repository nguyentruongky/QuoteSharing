//
//  BookDetailController.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit


class BookDetailController: knListController<QuoteCell, Quote> {
    let ui = UI()
    override func setupView() {
        super.setupView()
        rowHeight = 150
        view.addSubviews(views: tableView)
        tableView.fillSuperView()
        tableView.backgroundColor = UIColor.c_secondary
        
        let headerView = ui.makeHeaderView()
        tableView.setHeader(headerView, height: 275)
        
        getData()
        ui.addQuoteButton.addTarget(self, action: #selector(addQuote))
    }
    
    func getData() {
        ui.authorLabel.text = "Trump"
        ui.titleLabel.text = "The Crow's Vow"
        ui.coverImageView.downloadImage(from: "https://images-na.ssl-images-amazon.com/images/I/41o0Fkf%2BvfL._SY346_.jpg")
        datasource = [
            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
                  name: "Kono",
                  content: "So many books, so little time.",
                  timestamp: 1560248560),
            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
                  name: "Kono",
                  content: "A room without books is like a body without a soul.",
                  timestamp: 1560244560),
            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
                  name: "Kono",
                  content: "The person, be it gentleman or lady, who has not pleasure in a good novel, must be intolerably stupid.",
                  timestamp: 1560243560),
            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
                  name: "Kono",
                  content: "Good friends, good books, and a sleepy conscience: this is the ideal life.",
                  timestamp: 1560242560),
            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
                  name: "Kono",
                  content: "Fairy tales are more than true: not because they tell us that dragons exist, but because they tell us that dragons can be beaten.",
                  timestamp: 1510248560),
            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
                  name: "Kono",
                  content: "Outside of a dog, a book is man's best friend. Inside of a dog it's too dark to read.",
                  timestamp: 1563248560),
            Quote(avatar: "https://vignette.wikia.nocookie.net/hawaiifiveo/images/f/f8/Officer_Kono_Kalakaua.jpg/revision/latest?cb=20160204072320",
                  name: "Kono",
                  content: "I have always imagined that Paradise will be a kind of library.",
                  timestamp: 1360248560),
        ]
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
}
