//
//  StoryView.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/19/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

class StoryCell: knGridCell<Story> {
    override var data: Story? { didSet {
        contentLabel.text = data?.quoteContent
        if let cover = data?.coverImage {
            coverImageView.downloadImage(from: cover)
        } else if let bookId = data?.bookId {
            getBookCover(bookId: bookId)
        }
        
        if let avatar = data?.userAvatar {
            avatarImageView.downloadImage(from: avatar)
        } else if let readerId = data?.userId {
            getQuoterAvatar(readerId: readerId)
        }
        }}
    let contentLabel = UIMaker.makeLabel(font: .main(size: 15),
                                         color: .white,
                                         numberOfLines: 0,
                                         alignment: .center)
    let coverImageView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
    let avatarImageView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
    
    
    override func setupView() {
        let darkView = UIMaker.makeView(background: UIColor.black.alpha(0.8))
        darkView.setCorner(radius: 7)
        
        coverImageView.setCorner(radius: 7)
        coverImageView.setBorder(width: 1, color: UIColor.lightGray)
        
        
        let avatarHeight: CGFloat = 88
        avatarImageView.setCorner(radius: avatarHeight / 2)
        avatarImageView.setBorder(width: 2, color: .main)
        
        addSubviews(views: coverImageView, darkView, contentLabel, avatarImageView)
        coverImageView.horizontalSuperview()
        coverImageView.topSuperView()
        coverImageView.bottomSuperView(space: -space * 2)
        
        darkView.fill(toView: coverImageView)
        
        contentLabel.horizontalSuperview(space: 12)
        contentLabel.topSuperView(space: 12)
        contentLabel.bottomAnchor.constraint(lessThanOrEqualTo: coverImageView.bottomAnchor, constant: -space * 2).isActive = true
        
        avatarImageView.centerXSuperView()
        avatarImageView.square(edge: avatarHeight)
        avatarImageView.centerY(toAnchor: coverImageView.bottomAnchor)
    }
}

private extension StoryCell {
    func getBookCover(bookId: String) {
        DB().getCollection(.books)
            .document(bookId)
            .getDocument { (snapshot, err) in
                guard let rawData = snapshot?.data() else { return }
                let cover = rawData["cover"] as? String
                self.data?.coverImage = cover
                self.data?.bookTitle = rawData["title"] as? String
                self.coverImageView.downloadImage(from: cover)
        }
    }
    
    func getQuoterAvatar(readerId: String) {
        DB().getCollection(.users)
            .document(readerId)
            .getDocument { (snapshot, err) in
                guard let rawData = snapshot?.data() else { return }
                let avatar = rawData["avatar"] as? String
                self.data?.userAvatar = avatar
                self.avatarImageView.downloadImage(from: avatar)
        }
    }
}

class StoryView: knGridView<StoryCell, Story> {
    let nameLabel = UIMaker.makeLabel(text: "Stories",
                                      font: .main(.bold, size: 25),
                                      color: .main)
    override func setupView() {
        itemSize = CGSize(width: 170, height: 0)
        lineSpacing = space
        contentInset = UIEdgeInsets(left: space, right: space)
        super.setupView()
        collectionView.decelerationRate = .fast
        (layout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        
        addSubviews(views: nameLabel, collectionView)
        nameLabel.horizontalSuperview(space: space)
        nameLabel.topSuperView(space: 0)
        
        collectionView.horizontalSuperview()
        collectionView.verticalSpacing(toView: nameLabel, space: 16)
        collectionView.bottomSuperView()
    }
    
    override func didSelectItem(at indexPath: IndexPath) {
        let data = datasource[indexPath.row]
        let controller = StoryDetailController()
        controller.hidesBottomBarWhenPushed = true
        controller.setData(data)
        UIApplication.push(controller)
    }
}

