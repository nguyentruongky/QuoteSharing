//
//  Quote.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/12/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

struct Quote {
    var quoterId: String?
    var quoterName: String?
    var quoterAvatar: String?
    var id: String?
    var content: String?
    var timestamp: Double = 0
    var timeString: String?
    var bookId: String?
    
    init(avatar: String, name: String, content: String, timestamp: Double) {
        self.quoterAvatar = avatar
        self.quoterName = name
        self.content = content
        self.timestamp = timestamp
        let date = Date(timeIntervalSince1970: timestamp)
        timeString = date.toString("dd/MM/yyyy")
    }
}

class QuoteCell: knListCell<Quote> {
    override var data: Quote? { didSet {
        avatarImageView.downloadImage(from: data?.quoterAvatar)
        quoterNameLabel.text = data?.quoterName
        contentLabel.text = data?.content
        timestampLabel.text = data?.timeString
        }}
    
    let avatarImageView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
    let quoterNameLabel = UIMaker.makeLabel(font: .main(.semibold), color: .c_secondary)
    let contentLabel = UIMaker.makeLabel(font: .main(), color: .c_main, numberOfLines: 2)
    let timestampLabel = UIMaker.makeLabel(font: .main(.light, size: 11), color: .c_secondary)
    
    override func setupView() {
        backgroundColor = UIColor.clear
        let view = UIMaker.makeView(background: UIColor.white)
        view.setCorner(radius: 5)
        view.addSubviews(views: avatarImageView, quoterNameLabel, contentLabel, timestampLabel)
        avatarImageView.leftSuperView(space: 12)
        avatarImageView.topSuperView(space: 12)
        avatarImageView.square(edge: 44)
        avatarImageView.setCorner(radius: 22)
        
        quoterNameLabel.leftHorizontalSpacing(toView: avatarImageView, space: -12)
        quoterNameLabel.bottom(toAnchor: avatarImageView.centerYAnchor)
        
        timestampLabel.left(toView: quoterNameLabel)
        timestampLabel.verticalSpacing(toView: quoterNameLabel, space: 2)
        
        contentLabel.horizontalSuperview(space: 12)
        contentLabel.verticalSpacing(toView: avatarImageView, space: 12)
        
        addSubviews(views: view)
        view.fillSuperView(space: UIEdgeInsets(top: space, left: space, right: space))
    }
    
}
