//
//  QuoteDetailController.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/20/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit
import GrowingTextView

class StoryDetailController: knListController<CommentCell, Comment> {
    let ui = UI()
    lazy var headerView = ui.makeHeaderView()
    let commentBox = CommentBoxView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 48))
    
    override var inputAccessoryView: UIView? { return commentBox }
    
    override var canBecomeFirstResponder: Bool { return true }

    private var story: Story?
    func setData(_ data: Story) {
        self.story = data
        ui.contentLabel.text = data.quoteContent
        tableView.setHeader(headerView, height: 0)
        headerView.backgroundColor = .secondaryLight
    }
    
    override func setupView() {
        super.setupView()
        addBackButton(tintColor: .main)
        navigationController?.hideBar(false)
        setNavBarTitle(text: story?.bookTitle ?? "", font: .main(.bold), color: .main )
        
        view.addSubview(tableView)
        tableView.fillSuperView()
        
        tableView.keyboardDismissMode = .interactive
        commentBox.textView.delegate = self
        commentBox.sendButton.addTarget(self, action: #selector(sendComment))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let height = headerView.frame.height
        tableView.tableHeaderView = nil
        tableView.setHeader(headerView, height: height)
        headerView.layoutIfNeeded()
        
        getComments()
    }
}


extension StoryDetailController: GrowingTextViewDelegate {
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        commentBox.frame.size.height = height + 16
    }
    
    @objc func sendComment() {
        guard let quoteId = story?.quoteId,
            let userId = appSetting.myId else { return }
        let commentId = UUID().uuidString
        let data = [
            "quoteId": quoteId,
            "commentId": commentId,
            "content": commentBox.textView.text!,
            "userId": userId,
            "timestamp": Date().timeIntervalSince1970
            ] as [String : Any]
        DB().getCollection(.comments)
            .document(commentId).setData(data, merge: true)
    }
    
    func getComments() {
        guard let quoteId = story?.quoteId else { return }
        DB().getCollection(.comments)
            .whereField("quoteId", isEqualTo: quoteId)
            .getDocuments { (snapshot, err) in
                guard let rawData = snapshot?.documents.compactMap({ $0.data() as AnyObject? }) else { return }
                let comments = rawData.map({ return Comment(raw: $0) })
                self.datasource = comments
        }
    }
}
