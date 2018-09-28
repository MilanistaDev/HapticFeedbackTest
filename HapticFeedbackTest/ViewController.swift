//
//  ViewController.swift
//  HapticFeedbackTest
//
//  Created by 麻生 拓弥 on 2018/09/28.
//  Copyright © 2018年 com.ASTK. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var currentCountLabel: UILabel!
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusBarPartView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.textChanged(notification:)),
                                               name: UITextView.textDidChangeNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: nil)
    }

    fileprivate func setUpUI() {
        self.navigationItem.title = "Haptic feedback test"
        if #available(iOS 11.0, *) {
        } else {
            self.topLayoutConstraint.constant = -64.0
        }
        self.statusBarPartView.isHidden = true
        self.textView.delegate = self
        self.textView.text = ""
        self.currentCountLabel.text = String(self.textView.text.count)
        self.textView.layer.borderWidth = 1.0
        self.textView.layer.borderColor = UIColor(red: 0.0, green: 173.0/255.0, blue: 169.0/255.0, alpha: 1.0).cgColor
        self.sendButton.isEnabled = false
        self.sendButton.layer.cornerRadius = 5.0
    }

    @objc
    func textChanged(notification: Notification) {
        self.currentCountLabel.text = String(self.textView.text.count)
        self.sendButton.isEnabled = self.textView.text.count > 0 && self.textView.text.count < 11
        if self.textView.text.count > 10 {
            self.currentCountLabel.textColor = .red
        } else if self.textView.text.count > 7 && self.textView.text.count <= 10 {
            self.currentCountLabel.textColor = .orange
        } else {
            self.currentCountLabel.textColor = .black
        }
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
