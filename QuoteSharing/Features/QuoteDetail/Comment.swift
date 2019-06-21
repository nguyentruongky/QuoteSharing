//
//  Comment.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/20/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
class Comment {
    var quoteId: String?
    var commentId: String?
    var userId: String?
    var avatar: String?
    var readerName: String?
    var content: String?
    var timestamp: String?
    var timeString: String?
    
    init(raw: AnyObject) {
        quoteId = raw["quoteId"] as? String
        commentId = raw["commentId"] as? String
        content = raw["content"] as? String
        userId = raw["userId"] as? String
        if let timestamp = raw["timestamp"] as? Double {
            self.timestamp = String(timestamp)
            let date = Date(timeIntervalSince1970: timestamp)
            timeString = date.toString("dd/MM/yyyy")
        }
    }
}

class CommentCell: knListCell<Comment> {
    override var data: Comment? { didSet {
        quoterNameLabel.text = data?.readerName
        contentLabel.text = data?.content
        timestampLabel.text = data?.timeString
        
        if data?.avatar != nil {
            avatarImageView.downloadImage(from: data?.avatar)
        } else {
            guard let commenter = data?.userId else { return }
            getQuoterAvatar(readerId: commenter)
        }
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
    
    func getQuoterAvatar(readerId: String) {
        DB().getCollection(.users)
            .document(readerId)
            .getDocument { (snapshot, err) in
                guard let rawData = snapshot?.data() else { return }
                self.data?.readerName = rawData["name"] as? String
                self.quoterNameLabel.text = self.data?.readerName
                
                let avatar = rawData["avatar"] as? String
                self.data?.avatar = avatar
                self.avatarImageView.downloadImage(from: avatar)
        }
    }
}

