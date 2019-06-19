//
//  ImageSelector.swift
//  WorkshopFixir
//
//  Created by Ky Nguyen on 2/28/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

fileprivate protocol knPhotoSelectorDelegate: class {
    func present(_ controller: UIViewController)
    func didSelect(_ image: UIImage)
}

fileprivate class knPhotoSelector : NSObject {
    var delegate: knPhotoSelectorDelegate?
    var allowEditing: Bool = false
    
    func showSelection(allowChoosePhoto: Bool = true, allowEditing: Bool = false) {
        self.allowEditing = allowEditing
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if allowChoosePhoto {
            let pickPhoto = UIAlertAction(title: "Choose Photo", style: .default) { (action) in
                self.pickImageFromPhotoLibrary()
            }
            menu.addAction(pickPhoto)

        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (action) in
                self.takePhoto()
            }
            menu.addAction(takePhoto)
        }
        
        menu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        delegate?.present(menu)
    }
    deinit {
        print("Deinit \(NSStringFromClass(type(of: self)))")
    }
}

extension knPhotoSelector: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var pickedImage : UIImage
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            pickedImage = image
        } else {
            pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        }
        
        picker.dismiss(animated: true, completion: nil)
        delegate?.didSelect(pickedImage)
    }
    
    func takePhoto() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = allowEditing
        imagePicker.delegate = self
        delegate?.present(imagePicker)
    }
    
    func pickImageFromPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = allowEditing
        delegate?.present(imagePicker)
    }
}

class knPhotoSelectorWorker {
    var successResponse : ((UIImage) -> Void)? = nil
    var selectedImage : UIImage?
    fileprivate var picker: knPhotoSelector?
    var allowChoosePhoto: Bool
    var allowEditing: Bool
    init(finishSelection: ((UIImage) -> Void)?,
         allowChoosePhoto: Bool = true,
         allowEditing: Bool = true) {
        successResponse = finishSelection
        self.allowChoosePhoto = allowChoosePhoto
        self.allowEditing = allowEditing
    }
    
    func execute() {
        picker = knPhotoSelector()
        picker?.delegate = self
        picker?.showSelection(allowChoosePhoto: allowChoosePhoto, allowEditing: allowEditing)
    }
}

extension knPhotoSelectorWorker : knPhotoSelectorDelegate {
    func present(_ controller: UIViewController) {
        DispatchQueue.main.async {
            UIApplication.present(controller)
        }
    }
    func didSelect(_ image: UIImage) {
        
        selectedImage = image
        successResponse?(image)
        picker = nil
    }
}
