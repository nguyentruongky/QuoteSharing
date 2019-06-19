//
//  BookShelfUI.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

extension ExploreController {
    class UI {
        let coverImageView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
        let mostReadBooksView = BookShelfView(name: "Most read")
        let newBooksView = BookShelfView(name: "New")
    }
}

extension ExploreController.UI {
    func addShelf(_ view: UIView, shelfHeight: CGFloat) -> knTableCell {
        let cell = knTableCell.wrap(view: view, space: UIEdgeInsets(top: 32))
        cell.backgroundColor = .white
        cell.height(shelfHeight)
        return cell
    }
    
    func makeReadingView() -> UIView {
        let label = UIMaker.makeLabel(text: "Current reading", color: .main)
        let continueButton = UIMaker.makeMainButton(title: "Continue")
        let view = UIMaker.makeView(background: UIColor(r: 241, g: 243, b: 245))
        view.addSubviews(views: label, continueButton, coverImageView)
        label.leftSuperView(space: space)
        label.topSuperView(space: hasNotch() ? 44 + space : space)
        
        coverImageView.left(toView: label)
        coverImageView.verticalSpacing(toView: label, space: space)
        coverImageView.size(CGSize(width: 100, height: 164))
        
        continueButton.leftHorizontalSpacing(toView: coverImageView, space: -space)
        continueButton.rightSuperView(space: -space)
        continueButton.centerY(toView: coverImageView)
        
        return view
    }
}
