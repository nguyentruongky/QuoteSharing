//
//  StoryDetailController.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/20/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

extension StoryDetailController {
    class UI {
        let contentLabel = UIMaker.makeLabel(font: UIFont.main(), color: .main, numberOfLines: 0)
        func makeHeaderView() -> UIView {
            let header = UIMaker.makeView()
            header.addSubview(contentLabel)
            contentLabel.fillSuperView(space: UIEdgeInsets(space: space))
            return header
        }
    }
}

