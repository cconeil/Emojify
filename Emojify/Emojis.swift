//
//  Emojis.swift
//  Swiftmoji
//
//  Created by Chris O'Neil on 4/7/16.
//  Copyright © 2016 Because. All rights reserved.
//

import Foundation

public final class Emojis {
    enum Source {
        case Custom, Category, Keyword

        func emojiMap() -> EmojiMapType {
            switch self {
            case .Category:
                return Emojis.loadCategoryMap()
            case .Keyword:
                return Emojis.loadKeywordMap()
            default:
                return [:]
            }
        }
    }

    typealias EmojiType = String

    typealias EmojiMapType = [String : [EmojiType]]

    private var emojiMap: EmojiMapType

    init(source: Source) {
        emojiMap = source.emojiMap()
    }

    convenience init() {
        self.init(source: .Custom)
    }

    func add(emoji emoji: EmojiType, forKey key: String) {
        var emojis = emojiMap[key] ?? []
        emojis.append(emoji)
        emojiMap[key] = emojis
    }

    func remove(emoji emoji: EmojiType, forKey key: String) {
        if var emojis = emojiMap[key], let index = emojis.indexOf(emoji) {
            emojis.removeAtIndex(index)
        }
    }

    func emojis(key key: String) -> [EmojiType]? {
        return emojiMap[key]
    }

    func randomEmoji(key key: String) -> EmojiType? {
       return emojis(key: key)?.randomItem()
    }
}

extension Emojis {
    static func loadCategoryMap() -> EmojiMapType {
        var categoryMap: EmojiMapType = [:]
        let rawEmojis = loadRawEmojis()

        for (_, value) in rawEmojis {
            if let value = value as? NSDictionary {
                if let emoji = value["char"] as? String, category = value["category"] as? String {
                    var emojis = categoryMap[category] ?? []
                    emojis.append(emoji)
                    categoryMap[category] = emojis
                }
            }
        }
        return categoryMap
    }

    static func loadKeywordMap() -> EmojiMapType {
        var keywordMap: EmojiMapType = [:]
        let rawEmojis = loadRawEmojis()

        for (_, value) in rawEmojis {
            if let value = value as? NSDictionary {
                if let emoji = value["char"] as? String, keywords = value["keywords"] as? [String] {
                    for keyword in keywords {
                        var emojis = keywordMap[keyword] ?? []
                        emojis.append(emoji)
                        keywordMap[keyword] = emojis
                    }
                }
            }
        }
        return keywordMap
    }

    private static func loadRawEmojis() -> NSDictionary {
        guard let path = NSBundle.mainBundle().pathForResource("emoji_words", ofType: "json") else {
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
