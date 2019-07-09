//
//  UseCaseProvider.swift
//  MBNetworkPlatform
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation
import MBDomain

public final class UseCaseProvider: MBDomain.UseCaseProvider {
    private let networkProvider: NetworkProvider
    
    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func makeQuestionsUseCase() -> MBDomain.QuestionsUseCase {
        return QuestionsUseCase(network: networkProvider.makeQuestionsNetwork(),
                            cache: Cache<Question>(path: "allQuestions"))
    }
}
