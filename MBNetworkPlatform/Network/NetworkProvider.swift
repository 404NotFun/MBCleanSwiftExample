//
//  NetworkProvider.swift
//  MBNetworkPlatform
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation
import MBDomain

final class NetworkProvider {
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = Config.domain.rawValue
    }
    
    public func makeQuestionsNetwork() -> QuestionsNetwork {
        let network = Network<Question>(apiEndpoint)
        return QuestionsNetwork(network: network)
    }
}
