//
//  Encodable.swift
//  MBNetworkPlatform
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType: Identifiable
    
    init(with domain: DomainType)
    
    func asDomain() -> DomainType
}

protocol Identifiable {
    var uid: String { get }
}

typealias DomainConvertibleCoding = DomainConvertibleType

protocol Encodable {
    associatedtype Encoder: DomainConvertibleCoding
    
    var encoder: Encoder { get }
}
