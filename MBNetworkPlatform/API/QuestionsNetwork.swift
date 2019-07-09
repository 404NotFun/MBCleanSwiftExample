//
//  QuestionsNetwork.swift
//  MBNetworkPlatform
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation
import MBDomain
import RxSwift

public final class QuestionsNetwork {
    private let network: Network<Question>
    
    init(network: Network<Question>) {
        self.network = network
    }
    
    public func fetchQuestions() -> Observable<[Question]> {
        return network.getItems("questions?scope=latest&count=10")
    }
    
    public func fetchQuestion(questionId: String) -> Observable<Question> {
        return network.getItem("questions", itemId: questionId)
    }
    
    public func createQuestion(question: Question) -> Observable<Question> {
        return network.postItem("questions", parameters: question.toJSON())
    }
    
    public func deleteQuestion(questionId: String) -> Observable<Question> {
        return network.deleteItem("questions", itemId: questionId)
    }
}
