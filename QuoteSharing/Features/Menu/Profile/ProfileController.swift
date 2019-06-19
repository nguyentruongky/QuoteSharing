//
//  ProfileController.swift
//  Shopmate
//
//  Created by Ky Nguyen on 4/19/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//


import UIKit

class ProfileController: knStaticListController {
    let ui = UI()
    lazy var output = Interactor(controller: self)
    var data: Reader? { didSet {
        ui.nameTextField.text = data?.name
        ui.phoneTextField.text = data?.phone
        }}

    override func setupView() {
        title = "My Profile"
        addBackButton()

        navigationController?.hideBar(false)
        super.setupView()
        view.addSubviews(views: tableView)
        tableView.horizontalSuperview()
        tableView.top(toAnchor: view.safeAreaLayoutGuide.topAnchor, space: space)
        tableView.bottomSuperView()
        datasource = ui.setupView()

        view.addSubviews(views: ui.saveButton)
        ui.saveButton.horizontal(toView: view, space: 16)
        ui.saveButton.bottom(toView: view, space: -54)

        ui.saveButton.addTarget(self, action: #selector(saveChanges))

        fetchData()
    }

    override func fetchData() {
//        if appSetting.myAccount == nil {
//            output.getMyProfile()
//        } else {
//            data = appSetting.myAccount
//        }

    }

    @objc func saveChanges(){
        hideKeyboard()
        guard var user = data else { return }
        user.name = ui.nameTextField.text
        user.phone = ui.phoneTextField.text

        ui.saveButton.setProcess(visible: true)
        output.updateProfile(data: user)
    }
}
