//
//  BookDetailUI.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/12/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

extension BookDetailController {
    class UI {
        let titleLabel = UIMaker.makeLabel(font: .main(.bold, size: 18),
                                           color: .c_main,
                                           numberOfLines: 3)
        let authorLabel = UIMaker.makeLabel(font: .main(size: 13),
                                            color: .c_secondary)
        let coverImageView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
        let addQuoteButton = UIMaker.makeMainButton(title: "Add Quote")
        let addQuoteView = AddQuoteView()
        
        lazy var sectionHeaderView = makeSectionHeaderView()
        func makeHeaderView() -> UIView {
            coverImageView.setCorner(radius: 5)
            coverImageView.setBorder(width: 1, color: UIColor.lightGray)
            
            let detailView = UIMaker.makeStackView(axis: .vertical, alignment: .leading, space: 4)
            detailView.addViews(titleLabel, authorLabel)
            
            let view = UIMaker.makeView(background: .white)
            view.addSubviews(views: detailView, coverImageView)
            
            coverImageView.leftSuperView(space: space)
            coverImageView.topSuperView(space: space)
            coverImageView.size(CGSize(width: 100, height: 150))
            
            detailView.centerY(toView: coverImageView)
            detailView.leftHorizontalSpacing(toView: coverImageView, space: -space)
            let constraint = detailView.rightSuperView(space: -space, isActive: false)
            constraint?.priority = .init(rawValue: 900)
            constraint?.isActive = true
            
            view.addSubviews(views: addQuoteButton)
            addQuoteButton.horizontalSuperview(space: space)
            addQuoteButton.verticalSpacing(toView: coverImageView, space: space)
            
            return view
        }
        
        func makeSectionHeaderView() -> UIView {
            let view = UIView()
            view.backgroundColor = .white
            let titleLabel = UIMaker.makeLabel(text: "Quotes", font: .main(.bold, size: 25),
                                               color: .c_main)
            view.addSubviews(views: titleLabel)
            titleLabel.leftSuperView(space: space)
            titleLabel.centerYSuperView()
            
            let line = UIMaker.makeHorizontalLine(color: .c_secondary, height: 1)
            view.addSubviews(views: line)
            line.horizontalSuperview()
            line.bottomSuperView()
            return view
        }
    }
}

