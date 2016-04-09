//
//  Extensions.swift
//  Swiftmoji
//
//  Created by Chris O'Neil on 4/7/16.
//  Copyright © 2016 Because. All rights reserved.
//

import Foundation

extension String {
    func words() -> [String] {
        return componentsSeparatedByCharactersInSet(.punctuationCharacterSet()).joinWithSeparator("").componentsSeparatedByString(" ").filter{!$0.isEmpty}
    }

    func endsInWord() -> Bool {
        if let lastCharacter = self.characters.last {
            let character = String(lastCharacter)

            if character.rangeOfCharacterFromSet(NSCharacterSet.punctuationCharacterSet()) != nil {
                return true
            }
            if character.rangeOfCharacterFromSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) != nil {
                return true
            }
        }
        return false
    }
}

extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
