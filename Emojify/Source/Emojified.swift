//
//  Emojified.swift
//  Swiftmoji
//
//  Created by Chris O'Neil on 4/7/16.
//  Copyright © 2016 Because. All rights reserved.
//

import Foundation

import UIKit

let keywordEmojis = Emojis(source: .Keyword)

public protocol Emojified {
    mutating func emojify()
    mutating func emojify(emojis emojis: Emojis)
}

extension String : Emojified {
    public mutating func emojify() {
        emojify(emojis: keywordEmojis)
    }

    public mutating func emojify(emojis emojis: Emojis) {
        guard endsInWord() else {
            return
        }

        for word in words() {
            let key = word.lowercaseString
            if let emoji = emojis.randomEmoji(key: key), range = rangeOfString(word) {
                replaceRange(range, with: emoji)
            }
        }
    }
}

extension NSMutableAttributedString : Emojified {
    public func emojify() {
        emojify(emojis: keywordEmojis)
    }

    public func emojify(emojis emojis: Emojis) {
        guard string.endsInWord() else {
            return
        }

        for word in string.words() {
            let key = word.lowercaseString
            let nsstring = string as NSString
            let range = nsstring.rangeOfString(word)
            if let emoji = emojis.randomEmoji(key: key) where range.location != NSNotFound {
                let attributes = attributesAtIndex(range.location, effectiveRange: nil)
                replaceCharactersInRange(range, withAttributedString: NSAttributedString(string: emoji, attributes: attributes))
            }
        }
    }
}
