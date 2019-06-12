//
//  BookShelfUI.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

extension BookShelfController {
    class UI {
        let mostReadBooksView = BookShelfView(name: "Most read")
        let newBooksView = BookShelfView(name: "New")
    }
}

extension BookShelfController.UI {
    func addShelf(_ view: UIView, shelfHeight: CGFloat) -> knTableCell {
        let cell = knTableCell.wrap(view: view, space: UIEdgeInsets(top: 32))
        cell.height(shelfHeight)
        return cell
    }
}
