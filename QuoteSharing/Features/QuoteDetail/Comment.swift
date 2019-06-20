//
//  Comment.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/20/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
class Comment {
    var userId: String?
    var avatar: String?
    var readerName: String?
    var content: String?
    var timestamp: String?
    var timeString: String?
}

class CommentCell: knListCell<Comment> {
    override var data: Comment? { didSet {
        //        avatarImageView.downloadImage(from: data?.avatar)
        //        quoterNameLabel.text = data?.readerName
        //        contentLabel.text = data?.content
        //        timestampLabel.text = data?.timeString
        
        avatarImageView.downloadImage(from: "https://avatars0.githubusercontent.com/u/932822?s=460&v=4")
        quoterNameLabel.text = "Steve"
        contentLabel.text = "If you are building your app with iOS 10 or newer, you need to add two privacy keys to your app to allow the usage of the camera and photo library, or your app will crash."
        timestampLabel.text = "2 mins"
        }}
    let avatarImageView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
    let quoterNameLabel = UIMaker.makeLabel(font: .main(.semibold), color: .secondary)
    let contentLabel = UIMaker.makeLabel(font: .main(), color: .main, numberOfLines: 0)
    let timestampLabel = UIMaker.makeLabel(font: .main(size: 12), color: .secondary)
    
    override func setupView() {
        avatarImageView.square(edge: 44)
        avatarImageView.setCorner(radius: 22)
        avatarImageView.setBorder(width: 1.5, color: .main)
        
        addSubviews(views: avatarImageView, quoterNameLabel, contentLabel, timestampLabel)
        
        avatarImageView.topLeft(toView: self, top: space * 2, left: space)
        
        quoterNameLabel.leftHorizontalSpacing(toView: avatarImageView, space: -8)
        quoterNameLabel.bottom(toAnchor: avatarImageView.centerYAnchor, space: -4)
        
        contentLabel.left(toView: quoterNameLabel)
        contentLabel.rightSuperView(space: -space)
        contentLabel.verticalSpacing(toView: quoterNameLabel, space: 4)
        contentLabel.bottomSuperView()
        
        timestampLabel.rightSuperView(space: -space)
        timestampLabel.centerY(toView: quoterNameLabel)
    }
}

