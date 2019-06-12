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
    var id: String
    var content: String?
    var timestamp: Double = 0
    var timeString: String?
    var bookId: String?
    
    init(raw: AnyObject) {
        id = raw["id"] as? String ?? UUID().uuidString
        content = raw["content"] as? String
        bookId = raw["bookId"] as? String
        quoterId = raw["quoterId"] as? String
        timestamp = raw["timestamp"] as? Double ?? Date().timeIntervalSince1970
        timeString = Date(timeIntervalSince1970: timestamp).toString()
    }
    
    init() {
        id = UUID().uuidString
        let today = Date()
        timestamp = today.timeIntervalSince1970
        timeString = today.toString()
    }
    
    init(avatar: String, name: String, content: String, timestamp: Double) {
        id = UUID().uuidString
        self.quoterAvatar = avatar
        self.quoterName = name
        self.content = content
        self.timestamp = timestamp
        let date = Date(timeIntervalSince1970: timestamp)
        timeString = date.toString("dd/MM/yyyy")
    }
    
    func toDict() -> [String: Any] {
        var dict: [String : Any] = [
            "id": id,
            "timestamp": Date().timeIntervalSince1970
            ]
        if let data = content {
            dict["content"] = data
        }
        if let data = bookId {
            dict["bookId"] = data
        }
        if let data = quoterId {
            dict["quoterId"] = data
        }
        return dict
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
    let timestampLabel = UIMaker.makeLabel(font: .main(size: 12), color: .c_secondary)
    
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
