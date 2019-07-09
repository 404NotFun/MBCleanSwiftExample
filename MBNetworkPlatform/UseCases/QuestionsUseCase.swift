//
//  QuestionsUseCase.swift
//  MBNetworkPlatform
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation
import MBDomain
import RxSwift

final class QuestionsUseCase<Cache>: MBDomain.QuestionsUseCase where Cache: AbstractCache, Cache.T == Question {
    private let network: QuestionsNetwork
    private let cache: Cache
    
    init(network: QuestionsNetwork, cache: Cache) {
        self.network = network
        self.cache = cache
    }
    
    func questions() -> Observable<[Question]> {
        let fetchQuestions = cache.fetchObjects().asObservable()
        let stored = network.fetchQuestions()
            .flatMap {
                return self.cache.save(objects: $0).asObservable().map(to: [Question].self).concat(Observable.just($0))
        }
        
        return fetchQuestions.concat(stored)
    }
    
    func save(question: Question) -> Observable<Void> {
        return network.createQuestion(question: question)
            .map { _ in }
    }
}


struct MapFromNever: Error {}
extension ObservableType{
    func map<T>(to: T.Type) -> Observable<T> {
        return self.flatMap { _ in
            return Observable<T>.error(MapFromNever())
        }
    }
}
