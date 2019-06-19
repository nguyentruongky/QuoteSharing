//
//  ProfileUI.swift
//  Shopmate
//
//  Created by Ky Nguyen on 4/19/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

extension ProfileController {
    class UI: NSObject {
        let nameTextField = UIMaker.makeTextField(placeholder: "Your name")
        let phoneTextField = UIMaker.makeTextField(placeholder: "Phone number")

        let saveButton = UIMaker.makeMainButton(title: "Save")

        func setupView() -> [knTableCell] {
            nameTextField.autocapitalizationType = .words
            nameTextField.returnKeyType = .next
            
            nameTextField.keyboardType = .phonePad

            return [
                makeCell(tf: nameTextField),
                makeCell(tf: phoneTextField),
            ]
        }

        private func makeCell(tf: UITextField) -> knTableCell {
            let cell = knTableCell()
            cell.addSubviews(views: tf)
            tf.setCorner(radius: 5)
            tf.setBorder(width: 1, color: .lightGray)
            tf.setView(.left, space: 16)
            tf.fill(toView: cell, space: UIEdgeInsets(left: space, bottom: space, right: space))
            tf.height(50)
            return cell
        }
    }
}
