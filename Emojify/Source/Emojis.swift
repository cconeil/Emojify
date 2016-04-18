//
//  Emojis.swift
//  Swiftmoji
//
//  Created by Chris O'Neil on 4/7/16.
//  Copyright © 2016 Because. All rights reserved.
//

import Foundation

public final class Emojis {
    public enum Source {
        case Custom, Category, Keyword

        func emojiMap() -> Typeahead {
            switch self {
            case .Category:
                return Emojis.loadCategoryMap()
            case .Keyword:
                return Emojis.loadKeywordMap()
            default:
                return Typeahead()
            }
        }
    }

    public typealias EmojiType = String

    private var emojiMap: Typeahead

    public init(source: Source) {
        emojiMap = source.emojiMap()
    }

    public convenience init() {
        self.init(source: .Custom)
    }

    public func add(emoji emoji: EmojiType, forKey key: String) {
        emojiMap.add(word: emoji, forKey: key)
    }

    public func remove(emoji emoji: EmojiType, forKey key: String) {
        emojiMap.remove(word: emoji, forKey: key)
    }

    public func emojis(key key: String) -> [EmojiType] {
        return emojiMap.words(matching: key)
    }

    public func randomEmoji(key key: String) -> EmojiType? {
        let choices = emojis(key: key)
        if Bool(choices.count) {
            return choices.randomItem()
        } else {
            return nil
        }
    }
}

extension Emojis {
    static func loadCategoryMap() -> Typeahead {
        let categoryMap = Typeahead()
        let rawEmojis = loadRawEmojis()

        for (_, value) in rawEmojis {
            if let value = value as? NSDictionary {
                if let emoji = value["char"] as? String, category = value["category"] as? String {
                    categoryMap.add(word: emoji, forKey: category)
                }
            }
        }
        return categoryMap
    }

    static func loadKeywordMap() -> Typeahead {
        let keywordMap = Typeahead()
        let rawEmojis = loadRawEmojis()

        for (_, value) in rawEmojis {
            if let value = value as? NSDictionary {
                if let emoji = value["char"] as? String, keywords = value["keywords"] as? [String] {
                    for keyword in keywords {
                        keywordMap.add(word: emoji, forKey: keyword)
                    }
                }
            }
        }
        return keywordMap
    }

    private static func loadRawEmojis() -> NSDictionary {
        guard let path = NSBundle(forClass: self).pathForResource("emoji_words", ofType: "json") else {
            return NSDictionary()
        }

        do {
            let data = try NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary {
                return json
            }
        } catch {}
        return NSDictionary()
    }
}
