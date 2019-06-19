//
//  AddQuoteView.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/12/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
import MobileCoreServices
import TesseractOCR
import GPUImage
import ALCameraViewController
import Photos

class AddQuoteView: knPopup {
    let textView = UIMaker.makeTextView(color: .main)
    let addButton = UIMaker.makeMainButton(title: "Save")
    let placeholderView = UIMaker.makeStackView(axis: .horizontal, space: 4)
    
    override func setupView() {
        let label = UIMaker.makeLabel(text: "Quote goes here or ", color: .secondary)
        let button = UIMaker.makeButton(imageName: "camera")
        button.imageView?.changeColor(to: .secondary)
        button.tintColor = .secondary
        placeholderView.addViews(label, button)
        
        textView.addSubview(placeholderView)
        placeholderView.topLeft(toView: textView, top: 0, left: 4)
        
        super.setupView()
        container.addSubviews(views: textView, addButton)
        textView.horizontalSuperview(space: space)
        textView.topSuperView(space: space)
        textView.height(120)
        
        addButton.horizontal(toView: textView)
        addButton.verticalSpacing(toView: textView, space: space)
        addButton.bottomSuperView(space: -space)
        
        textView.delegate = self
        button.addTarget(self, action: #selector(takePhoto))
    }
    
    var cameraController: CameraViewController?
    @objc func takePhoto() {
        let cropOptions = CroppingParameters(isEnabled: true, allowResizing: true, allowMoving: true, minimumSize: CGSize(width: 0, height: 0))
        let controller = CameraViewController(
        croppingParameters: cropOptions,
        allowsLibraryAccess: false,
        allowsSwapCameraOrientation: false,
        allowVolumeButtonCapture: true, completion: didTakePhoto)
        UIApplication.present(controller)
        cameraController = controller
    }
    
    private func didTakePhoto(image: UIImage?, asset: PHAsset?) {
        cameraController?.dismiss()
        guard let image = image else { return }
        performImageRecognition(image: image)
    }
    
    private func performImageRecognition(image: UIImage) {
        textView.showLoading(style: .gray)
        DispatchQueue.global(qos: .background).async { [weak self] in
            let scaledImage = image.scaledImage(1000) ?? image
            let preprocessedImage = scaledImage.preprocessedImage() ?? scaledImage
            
            if let tesseract = G8Tesseract(language: "eng+fra") {
                tesseract.engineMode = .tesseractCubeCombined
                tesseract.pageSegmentationMode = .auto
                
                tesseract.image = preprocessedImage
                tesseract.recognize()
                let text = tesseract.recognizedText
                DispatchQueue.main.async {
                    self?.textView.text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
                    self?.updatePlaceholder()
                    self?.textView.stopLoading()
                }
                
            }
        }
    }
    
    override func dismiss() {
        super.dismiss()
        textView.text = ""
        updatePlaceholder()
    }
    
    func updatePlaceholder() {
        placeholderView.isHidden = !textView.text.isEmpty
    }
}

extension AddQuoteView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholder()
    }
}
