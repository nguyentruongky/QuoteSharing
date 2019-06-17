//
//  AddQuoteView.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/12/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
class AddQuoteView: knPopup {
    let textView = UIMaker.makeTextView(placeholder: "Quote goes here",
                                        color: .main)
    let addButton = UIMaker.makeMainButton(title: "Save")
    override func setupView() {
        super.setupView()
        container.addSubviews(views: textView, addButton)
        textView.horizontalSuperview(space: space)
        textView.topSuperView(space: space)
        textView.height(120)
        
        addButton.horizontal(toView: textView)
        addButton.verticalSpacing(toView: textView, space: space)
        addButton.bottomSuperView(space: -space)
    }
}
