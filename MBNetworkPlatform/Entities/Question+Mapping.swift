//
//  NETPost.swift
//  MBNetworkPlatform
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation
import MBDomain

extension Question: Identifiable {
    var uid: String {
        return "\(id)"
    }
}

extension Question {
    func toJSON() -> [String: Any] {
        return [
            "id": id,
            "title": title,
            "content": content
        ]
    }
}

extension Question: Encodable {
    var encoder: NETQuestion {
        return NETQuestion(with: self)
    }
}

final class NETQuestion: NSObject, NSCoding, DomainConvertibleType {
    struct Keys {
        static let id = "id"
        static let title = "title"
        static let content = "content"
        static let createdAt = "created_at"
        static let updatedAt = "updated_at"
    }
    let id: Int
    let title: String
    let content: String
    let updatedAt: String
    let createdAt: String
    
    init(with domain: Question) {
        self.id = domain.id
        self.title = domain.title
        self.content = domain.content
        self.updatedAt = domain.updatedAt
        self.createdAt = domain.createdAt
    }
    
    init?(coder aDecoder: NSCoder) {
        guard
            let id = aDecoder.decodeObject(forKey: Keys.id) as? Int,
            let title = aDecoder.decodeObject(forKey: Keys.title) as? String,
            let content = aDecoder.decodeObject(forKey: Keys.content) as? String,
            let updatedAt = aDecoder.decodeObject(forKey: Keys.updatedAt) as? String,
            let createdAt = aDecoder.decodeObject(forKey: Keys.createdAt) as? String
            else {
                return nil
        }
        self.id = id
        self.title = title
        self.content = content
        self.updatedAt = updatedAt
        self.createdAt = createdAt
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Keys.id)
        aCoder.encode(title, forKey: Keys.title)
        aCoder.encode(content, forKey: Keys.content)
        aCoder.encode(updatedAt, forKey: Keys.updatedAt)
        aCoder.encode(createdAt, forKey: Keys.createdAt)
    }
    
    func asDomain() -> Question {
        return Question(id: id, title: title, content: content, createdAt: createdAt, updatedAt: updatedAt)
    }
}
