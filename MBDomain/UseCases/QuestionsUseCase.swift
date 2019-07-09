//
//  QuestionsUseCase.swift
//  MBDomain
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation
import RxSwift

public protocol QuestionsUseCase {
    func questions() -> Observable<[Question]>
    func save(question: Question) -> Observable<Void>
}
