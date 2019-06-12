//
//  BookCategoryView.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

class BookCell: knGridCell<Book> {
    override var data: Book? { didSet {
        titleLabel.text = data?.title
        authorLabel.text = data?.author
        coverImageView.downloadImage(from: data?.cover)
        }}
    let titleLabel = UIMaker.makeLabel(font: .main(.bold, size: 18),
                                       color: .c_main)
    let authorLabel = UIMaker.makeLabel(font: .main(size: 13),
                                        color: .c_secondary)
    let coverImageView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
    
    
    override func setupView() {
        coverImageView.setCorner(radius: 5)
        coverImageView.setBorder(width: 1, color: UIColor.lightGray)
        
        addSubviews(views: coverImageView, titleLabel, authorLabel)
        coverImageView.horizontalSuperview()
        coverImageView.topSuperView()
        
        titleLabel.verticalSpacing(toView: coverImageView, space: 12)
        titleLabel.horizontal(toView: coverImageView)
        
        authorLabel.horizontal(toView: titleLabel)
        authorLabel.verticalSpacing(toView: titleLabel, space: 4)
        authorLabel.bottomSuperView(space: -4)
        
        coverImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        authorLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

class BookShelfView: knGridView<BookCell, Book> {
    let nameLabel = UIMaker.makeLabel(font: .main(.bold, size: 25),
                                       color: .c_main)
    convenience init(name: String) {
        self.init(frame: .zero)
        nameLabel.text = name
    }
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
}
