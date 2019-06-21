//
//  CommentBoxView.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/21/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
import GrowingTextView

class CommentBoxView: knView {
    let textView: GrowingTextView = {
       let tv = GrowingTextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.placeholder = "Your comment"
        tv.font = .main()
        tv.isScrollEnabled = false
        tv.textColor = .main
        return tv
    }()
    
    let sendButton = UIMaker.makeButton(title: "Send")
    override func setupView() {
        translatesAutoresizingMaskIntoConstraints = true
        addSubviews(views: textView, sendButton)
        stackHorizontally(views: [textView, sendButton], viewSpaces: 8, leftSpace: 16, rightSpace: 16)
        textView.verticalSuperview(space: 8)
        sendButton.bottomSuperView(space: -8)
        backgroundColor = .green
    }
}
