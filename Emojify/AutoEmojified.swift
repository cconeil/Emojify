//
//  AutoEmojified.swift
//  Swiftmoji
//
//  Created by Chris O'Neil on 4/8/16.
//  Copyright © 2016 Because. All rights reserved.
//

import Foundation
import UIKit

protocol AutoEmojified {
    var emojis: Emojis { get }
    func startEmojifying()
    func stopEmojifying()
}

extension AutoEmojified {
    var emojis: Emojis {
        return keywordEmojis
    }
}

extension UITextField: AutoEmojified {
    func startEmojifying() {
        guard actionsForTarget(self, forControlEvent: .EditingChanged)?.contains("bc_valueChanged:") != true else {
            assert(false, "You should only call startEmojifying() once.")
            return
        }
        addTarget(self, action: "bc_valueChanged:", forControlEvents: .EditingChanged)
    }

    func stopEmojifying() {
        guard actionsForTarget(self, forControlEvent: .EditingChanged)?.contains("bc_valueChanged:") == true else {
            assert(false, "You should only call stopEmojifying() while the object is emojifying.")
            return
        }
        removeTarget(self, action: "bc_valueChanged:", forControlEvents: .EditingChanged )
    }

    @objc private func bc_valueChanged(sender: UITextField) {
        if var text = text {
            text.emojify(emojis: emojis)
            self.text = text
        } else if let attributedText = attributedText {
            let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
            mutableAttributedText.emojify(emojis: emojis)
            self.attributedText = mutableAttributedText
        }
    }
}

extension UITextView: AutoEmojified {
    func startEmojifying() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "bc_textChanged:", name: UITextViewTextDidChangeNotification, object: nil)
    }

    func stopEmojifying() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: nil)
    }

    @objc private func bc_textChanged(sender: UITextView) {
        guard isFirstResponder() else {
            return
        }
        if var text = text {
            text.emojify(emojis: emojis)
            self.text = text
        } else if let attributedText = attributedText {
            let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
            mutableAttributedText.emojify(emojis: emojis)
            self.attributedText = mutableAttributedText
        }
    }
}
