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

protocol Emojified {
    mutating func emojify()
    mutating func emojify(emojis emojis: Emojis)
}

extension String : Emojified {
    mutating func emojify() {
        emojify(emojis: keywordEmojis)
    }

    mutating func emojify(emojis emojis: Emojis) {
        guard endsInWord() else {
            return
        }

        for word in words() {
            if let emoji = emojis.randomEmoji(key: word), range = rangeOfString(word) {
                replaceRange(range, with: emoji)
            }
        }
    }
}

extension NSMutableAttributedString : Emojified {
    func emojify() {
        emojify(emojis: keywordEmojis)
    }

    func emojify(emojis emojis: Emojis) {
        guard string.endsInWord() else {
            return
        }

        for word in string.words() {
            let nsstring = string as NSString
            let range = nsstring.rangeOfString(word)
            if let emoji = emojis.randomEmoji(key: word) where range.location != NSNotFound {
                let attributes = attributesAtIndex(range.location, effectiveRange: nil)
                replaceCharactersInRange(range, withAttributedString: NSAttributedString(string: emoji, attributes: attributes))
            }
        }
    }
}
