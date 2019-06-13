//
//  MessageHub.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/13/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
import GSMessages

class MessageHub {
    static func show(_ message: String?, title: String?,
                     cancelActionName: String? = "OK") -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if cancelActionName != nil {
            controller.addAction(UIAlertAction(title: cancelActionName, style: .destructive, handler: nil))
        }
        return controller
    }
    
    static func showError(_ message: String) {
        showShortMessage(content: message, type: .error)
    }
    
    static func showSuccess(_ message: String) {
        showShortMessage(content: message, type: .success)
    }
    
    private static func showShortMessage(content: String, type: GSMessageType) {
        let controller = UIApplication.topViewController()
        controller?.showMessage(content, type: type)
    }
}
