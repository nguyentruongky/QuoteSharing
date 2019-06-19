//
//  ProfileInteractor.swift
//  Shopmate
//
//  Created by Ky Nguyen on 4/19/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
extension ProfileController {
    func didGetProfile(data: Reader) {
        self.data = data
        appSetting.myself = data
    }

    func didGetProfileFail(error: knError) {
        MessageHub.showError(error.message ?? "Fail to get your profile")
    }

    func didUpdateProfile() {
        MessageHub.showSuccess("Profile updated")
        ui.saveButton.setProcess(visible: false)
    }

    func didUpdateProfileFail(error: knError) {
        MessageHub.showError(error.message ?? "Fail to update your profile")
        ui.saveButton.setProcess(visible: false)
    }
}

extension ProfileController {
    class Interactor {
        func getMyProfile() {
//            GetProfileWorker(successAction: output?.didGetProfile,
//                             failAction: output?.didGetProfileFail).execute()
        }

        func updateProfile(data: Reader) {
//            UpdateProfileWorker(user: data,
//                                success: output?.didUpdateProfile,
//                                fail: output?.didUpdateProfileFail).execute()
        }

        private weak var output: Controller?
        init(controller: Controller) { output = controller }
    }
    typealias Controller = ProfileController
}
