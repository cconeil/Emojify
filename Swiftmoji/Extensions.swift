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

    // TODO: Add function to check if the string ends in a word so we can go back and change the text.

//    func endsInWord() -> Bool {
//        return true
//    }
}

extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
