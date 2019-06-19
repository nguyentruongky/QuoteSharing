//
//  AddBookUI.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/11/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

extension AddBookController {
    class UI {
        let titleTextField = UIMaker.makeTextField(placeholder: "Book Title",
                                                   font: .main(),
                                                   color: .main)
        let authorTextField = UIMaker.makeTextField(placeholder: "Author",
                                                    font: .main(),
                                                    color: .main)
        let coverImageView = UIMaker.makeImageView(contentMode: .scaleAspectFill)
        let addButton = UIMaker.makeMainButton(title: "Add book")
        let selectPhotoButton = UIMaker.makeButton(image: UIImage(named: "camera"))

        func setupView() -> [knTableCell] {
            let coverCell = makeCoverImageCell()
            coverCell.height(400)

            return [
                coverCell,
                makeTextCell(textField: titleTextField),
                makeTextCell(textField: authorTextField),
                makeAddButtonCell()
            ]
        }
        
        
    }
}

private extension AddBookController.UI {
    func makeTextCell(textField: UITextField) -> knTableCell {
        textField.autocorrectionType = .no
        textField.setPlaceholderColor(.secondary)
        textField.setCorner(radius: 7)
        textField.setBorder(width: 0.5, color: .secondary)
        textField.height(44)
        textField.setView(.left, space: 16)
        return knTableCell.wrap(view: textField, space: UIEdgeInsets(top: space, left: space, right: space))
    }
    
    func makeCoverImageCell() -> knTableCell {
        coverImageView.setCorner(radius: 7)
        coverImageView.setBorder(width: 1, color: .lightGray)
        
        let label = UIMaker.makeLabel(text: "Book cover", color: .secondary)

        selectPhotoButton.imageEdgeInsets = UIEdgeInsets(space: 6)
        let cell = knTableCell()
        cell.addSubviews(views: label, selectPhotoButton, coverImageView)
        
        coverImageView.width(200)
        coverImageView.centerXSuperView()
        coverImageView.topSuperView(space: space * 2)
        coverImageView.bottomSuperView(space: -space)
        
        selectPhotoButton.fill(toView: coverImageView)
        selectPhotoButton.imageView?.changeColor(to: .secondary)
        
        label.centerXSuperView()
        label.centerYSuperView(space: space)
        
        
        coverImageView.downloadImage(from: "https://images-na.ssl-images-amazon.com/images/I/41o0Fkf%2BvfL.jpg")
        return cell
    }
    
    func makeAddButtonCell() -> knTableCell {
        return knTableCell.wrap(view: addButton, space: UIEdgeInsets(space: space))
    }
}
