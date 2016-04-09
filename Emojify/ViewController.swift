//
//  ViewController.swift
//  Swiftmoji
//
//  Created by Chris O'Neil on 4/7/16.
//  Copyright © 2016 Because. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private(set) lazy var textFieldLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Text Field", comment: "")
        return label
    }()

    private(set) lazy var textField: UITextField = {
        let textField = UITextField(frame: CGRect.zero)
        textField.font = UIFont.systemFontOfSize(20.0)
        textField.startEmojifying()
        return textField
    }()

    private(set) lazy var textViewLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Text View", comment: "")
        return label
    }()

    private(set) lazy var textView: UITextView = {
        let textView = UITextView(frame: CGRect.zero)
        textView.font = UIFont.systemFontOfSize(20.0)
        textView.startEmojifying()
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textFieldLabel)
        view.addSubview(textField)
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.greenColor().CGColor

        view.addSubview(textViewLabel)
        view.addSubview(textView)
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.redColor().CGColor
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let width = view.frame.size.width
        textFieldLabel.frame = CGRect(x: width, y: 50.0, width: width, height: 50.0)
        textField.frame = CGRect(x: 0.0, y: 100.0, width: width, height: 50.0)

        textViewLabel.frame = CGRect(x: 0.0, y: 200.0, width: width, height: 50.0)
        textView.frame = CGRect(
            x: 0.0,
            y: 250.0,
            width: width,
            height: view.frame.size.height - 100.0
        )
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
}

