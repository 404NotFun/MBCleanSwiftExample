//
//  UseCaseProvider.swift
//  MBDomain
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {
    
    func makeQuestionsUseCase() -> QuestionsUseCase
}
