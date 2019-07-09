//
//  Question.swift
//  MBDomain
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation

public struct Question: Codable {
    public let id: Int
    public let title: String
    public let content: String
    public let createdAt: String
    public let updatedAt: String
    
    public init(id: Int, title: String, content: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        content = try container.decode(String.self, forKey: .content)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        
//        if let createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt) {
//            self.createdAt = "\(createdAt)"
//        } else {
//            createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
//        }
//
//        if let userId = try container.decodeIfPresent(Int.self, forKey: .userId) {
//            self.userId = "\(userId)"
//        } else {
//            userId = try container.decode(String.self, forKey: .userId)
//        }
//
//        if let uid = try container.decodeIfPresent(Int.self, forKey: .uid) {
//            self.uid = "\(uid)"
//        } else {
//            uid = try container.decodeIfPresent(String.self, forKey: .uid) ?? ""
//        }
    }
}

extension Question: Equatable {
    public static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.id == rhs.id
    }
}
