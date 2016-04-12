//
//  Typeahead.swift
//  Emojify
//
//  Created by Chris O'Neil on 4/9/16.
//  Copyright © 2016 Because. All rights reserved.
//

import Foundation

public final class Typeahead {

    private struct Constants {
        private static let WordsKey = "words"
    }

    typealias StoreType = NSMutableDictionary

    private let store = StoreType()

    func words(startingWith key: String) -> [String] {
        if let substore = substore(key: key) {
            return wordsFromStore(store: substore)
        } else {
            return []
        }
    }

    func words(matching key: String) -> [String] {
        return substore(key: key)?[Constants.WordsKey] as? [String] ?? []
    }

    func add(word word: String, forKey key: String) {
        var store = self.store
        for character in key.characters {
            let storeKey = String(character)
            var substore = store[storeKey]
            if substore == nil {
                substore = StoreType()
                store[storeKey] = substore
            }
            store = substore as! StoreType
        }

        if let words = store[Constants.WordsKey] as? NSMutableArray {
            words.addObject(word)
        } else {
            store[Constants.WordsKey] = NSMutableArray(object: word)
        }
    }

    func remove(word word: String, forKey key: String) {
        var store = self.store
        for character in key.characters {
            let storeKey = String(character)
            guard let substore = store[storeKey] else {
                return
            }
            store = substore as! StoreType
        }

        if let words = store[Constants.WordsKey] as? NSMutableArray {
            words.removeObject(word)
        }
    }

    func removeAll() {
        store.removeAllObjects()
    }

    private func wordsFromStore(store store: StoreType) -> [String] {
        var allWords: [String] = []
        for (key, value) in store {
            if let words = value as? [String], let key = key as? String where key == Constants.WordsKey {
                allWords += words
            } else {
                allWords += wordsFromStore(store: value as! StoreType)
            }
        }
        return allWords
    }

    private func substore(key key: String) -> StoreType? {
        var store = self.store
        for character in key.characters {
            let storeKey = String(character)
            guard let substore = store[storeKey] as? StoreType else {
                return nil
            }
            store = substore
        }
        return store
    }
}
