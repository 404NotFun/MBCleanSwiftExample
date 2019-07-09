//
//  QuestionItemViewModel.swift
//  MBCleanSwiftExample
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation
import MBDomain

final class QuestionItemViewModel   {
    let title:String
    let subtitle : String
    let question: Question
    init (with question: Question) {
        self.question = question
        self.title = question.title.uppercased()
        self.subtitle = question.content
    }
}
