//
//  QuestionsViewModel.swift
//  MBCleanSwiftExample
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation
import MBDomain
import RxSwift
import RxCocoa

final class QuestionsViewModel: ViewModelType {
    struct Input {
        let trigger: Driver<Void>
//        let createQuestionTrigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    struct Output {
        let fetching: Driver<Bool>
        let questions: Driver<[QuestionItemViewModel]>
//        let createQuestion: Driver<Void>
        let selectedQuestion: Driver<Question>
        let error: Driver<Error>
    }
    
    private let useCase: QuestionsUseCase
    private let navigator: QuestionsNavigator
    
    init(useCase: QuestionsUseCase, navigator: QuestionsNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let questions = input.trigger.flatMapLatest {
            return self.useCase.questions()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { QuestionItemViewModel(with: $0) } }
        }
    
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        let selectedQuestion = input.selection
            .withLatestFrom(questions) { (indexPath, questions) -> Question in
                return questions[indexPath.row].question
            }
            .do(onNext: navigator.toQuestion(_:))
//        let createPost = input.createQuestionTrigger
//            .do(onNext: navigator.toCreatePost)

        return Output(fetching: fetching,
                      questions: questions,
                      selectedQuestion: selectedQuestion,
                      error: errors)
    }
}
