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
                                                   color: .c_main)
        let authorTextField = UIMaker.makeTextField(placeholder: "Author",
                                                    font: .main(),
                                                    color: .c_main)
        let coverImageView = UIMaker.makeImageView()
        let addButton = UIMaker.makeMainButton(title: "Add book")
        let selectPhotoButton = UIMaker.makeButton(image: UIImage(named: "camera"))

        func setupView() -> [knTableCell] {
            let coverCell = makeCoverImageCell()
            coverCell.height(400)
            coverImageView.backgroundColor = .green

            return [
                makeTextCell(textField: titleTextField),
                makeTextCell(textField: authorTextField),
                coverCell,
                makeAddButtonCell()
            ]
        }
        
        
    }
}

private extension AddBookController.UI {
    func makeTextCell(textField: UITextField) -> knTableCell {
        textField.setPlaceholderColor(.c_secondary)
        textField.setCorner(radius: 5)
        textField.setBorder(0.5, color: .c_secondary)
        textField.height(44)
        textField.setView(.left, space: 16)
        return knTableCell.wrap(view: textField, space: UIEdgeInsets(top: space, left: space, right: space))
    }
    
    func makeCoverImageCell() -> knTableCell {
        let label = UIMaker.makeLabel(text: "Book cover", color: .c_secondary)

        selectPhotoButton.imageEdgeInsets = UIEdgeInsets(space: 6)
        let cell = knTableCell()
        cell.addSubviews(views: label, selectPhotoButton, coverImageView)
        label.leftSuperView(space: space)
        label.topSuperView(space: space * 1.5)
        
        selectPhotoButton.square(edge: 44)
        selectPhotoButton.centerY(toView: label)
        selectPhotoButton.leftHorizontalSpacing(toView: label, space: -space)
        
        coverImageView.horizontalSuperview()
        coverImageView.verticalSpacing(toView: label, space: space)
        coverImageView.bottomSuperView(space: -space)
        
        return cell
    }
    
    func makeAddButtonCell() -> knTableCell {
        return knTableCell.wrap(view: addButton, space: UIEdgeInsets(space: space))
    }
}
