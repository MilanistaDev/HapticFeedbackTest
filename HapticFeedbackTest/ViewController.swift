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

    var feedbackGenerator : UINotificationFeedbackGenerator? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.textChanged(notification:)),
                                               name: UITextView.textDidChangeNotification, object: nil)
        self.feedbackGenerator = UINotificationFeedbackGenerator()
        self.feedbackGenerator?.prepare()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.feedbackGenerator = nil
    }

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UITextView.textDidChangeNotification,
                                                  object: nil)
    }

    fileprivate func setUpUI() {
        self.navigationItem.title = "Haptic feedback test"
        if #available(iOS 11.0, *) {
        } else {
            self.topLayoutConstraint.constant = -64.0
        }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                                                        NSAttributedString.Key.font : UIFont(name: "Futura-Medium", size: 18.0)!]
        self.statusSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Futura-Medium", size: 14.0)!], for: .normal)
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

        // textColor assistance
        // 8-10 characters: Orange, 11 over: Red, Others: Black
        if self.textView.text.count > 10 {
            self.currentCountLabel.textColor = .red
        } else if self.textView.text.count > 7 && self.textView.text.count <= 10 {
            self.currentCountLabel.textColor = .orange
        } else {
            self.currentCountLabel.textColor = .black
        }

        // 8 characters: Warning, 10 Characters: Failure, 12 Characters: Failure again
        if self.textView.text.count == 8 {
            self.feedbackGenerator?.notificationOccurred(.warning)
        } else if self.textView.text.count == 10 || self.textView.text.count == 12 {
            self.feedbackGenerator?.notificationOccurred(.error)
        }
    }

    @IBAction func sendAction(_ sender: Any) {
        switch self.statusSegmentedControl.selectedSegmentIndex {
        case 0:
            self.feedbackGenerator?.notificationOccurred(.success)
            self.statusLabel.text = "Success"
            self.statusBarPartView.backgroundColor = .green
        case 1:
            self.feedbackGenerator?.notificationOccurred(.error)
            self.statusLabel.text = "Failure"
            self.statusBarPartView.backgroundColor = .red
            UIView.animate(withDuration: 1.0,
                           delay: 0.0,
                           usingSpringWithDamping: 0.1,
                           initialSpringVelocity: 0.0,
                           options: [],
                           animations: {
                            self.sendButton.center.x += 5.0
            }) { (_) in
                self.sendButton.center.x -= 5.0
            }
        default:
            break
        }
        self.statusBarPartView.isHidden = false
        UIView.animate(withDuration: 1.5, delay: 1.0, options: .curveEaseInOut,
                       animations: {
                        self.statusBarPartView.isHidden = true
        }, completion: nil)
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
