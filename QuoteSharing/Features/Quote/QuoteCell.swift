//
//  QuoteCell.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/13/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

class QuoteCell: knListCell<Quote> {
    override var data: Quote? { didSet {
        avatarImageView.downloadImage(from: data?.quoterAvatar)
        quoterNameLabel.text = data?.quoterName
        contentLabel.text = data?.content
        timestampLabel.text = data?.timeString
        getQuoterIfNeeded()
        }}
    
    let avatarImageView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
    let quoterNameLabel = UIMaker.makeLabel(font: .main(.semibold), color: .secondary)
    let contentLabel = UIMaker.makeLabel(font: .main(), color: .main, numberOfLines: 2)
    let timestampLabel = UIMaker.makeLabel(font: .main(size: 12), color: .secondary)
    
    override func setupView() {
        backgroundColor = UIColor.clear
        let view = UIMaker.makeView(background: UIColor.white)
        view.setCorner(radius: 7)
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
    
    func getQuoterIfNeeded() {
        if data?.quoterName != nil { return }
        guard let id = data?.quoterId else { return }
        GetQuoterWorker(quoterId: id, successAction: { [weak self] quoter in
            var newQuote = self?.data
            newQuote?.quoterName = quoter.name
            newQuote?.quoterAvatar = quoter.avatar
            self?.data = newQuote
        }).execute()
    }
}

