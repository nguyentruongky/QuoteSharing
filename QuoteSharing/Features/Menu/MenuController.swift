//
//  Setting.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/17/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

class MenuController: knStaticListController {
    let ui = UI()
    
    override func setupView() {
        title = "Settings"
        tableView.backgroundColor = UIColor(r: 243, g: 245, b: 248)
        navigationController?.hideBar(false)
        super.setupView()
        view.addSubviews(views: tableView)
        tableView.fillSuperView()
        
        datasource = ui.setupView()
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        guard let item = Item(rawValue: cell.tag) else { return }
        selectMenu(item)
    }
    
    func selectMenu(_ menu: Item) {
        switch menu {
        case .readBooks:
            break
            
        case .profile:
            showPush(ProfileController())
            break
            
        case .readTime:
            break
            
        case .logout:
            logout()
            
        default:
            break
        }
    }
    
    func showPush(_ ctr: UIViewController) {
        ctr.hidesBottomBarWhenPushed = true
        DispatchQueue.main.async { [weak self] in
            self?.push(ctr)
        }
    }
    
    func showPresent(_ ctr: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            self?.present(ctr)
        }
    }
    
    func logout() {
        let controller = MessageHub.show("Continue logout?", title: nil, cancelActionName: "No")
        controller.addAction(UIAlertAction(title: "Logout", style: .default, handler: { _ in
//            boss?.showLandingPage()
        }))
        showPresent(controller)
    }
}

extension MenuController {
    enum Item: Int {
        case profile
        case changePass
        case readBooks
        case readTime
        case term
        case logout
        case login
        case register
    }
}
