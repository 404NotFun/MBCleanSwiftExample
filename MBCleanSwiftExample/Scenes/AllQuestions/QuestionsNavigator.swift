//
//  QuestionsNavigator.swift
//  MBCleanSwiftExample
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation
import MBDomain

protocol QuestionsNavigator {
    func toCreateQuestion()
    func toQuestion(_ question: Question)
    func toQuestions()
}

class DefaultQuestionsNavigator: QuestionsNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: UseCaseProvider
    
    init(services: UseCaseProvider,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toQuestions() {
        let vc = storyBoard.instantiateViewController(ofType: QuestionsViewController.self)
        vc.viewModel = QuestionsViewModel(useCase: services.makeQuestionsUseCase(),
                                      navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toCreateQuestion() {
//        let navigator = DefaultCreatePostNavigator(navigationController: navigationController)
//        let viewModel = CreatePostViewModel(createPostUseCase: services.makePostsUseCase(),
//                                            navigator: navigator)
//        let vc = storyBoard.instantiateViewController(ofType: CreatePostViewController.self)
//        vc.viewModel = viewModel
//        let nc = UINavigationController(rootViewController: vc)
//        navigationController.present(nc, animated: true, completion: nil)
    }
    
    func toQuestion(_ question: Question) {
//        let navigator = DefaultEditPostNavigator(navigationController: navigationController)
//        let viewModel = EditPostViewModel(post: post, useCase: services.makePostsUseCase(), navigator: navigator)
//        let vc = storyBoard.instantiateViewController(ofType: EditPostViewController.self)
//        vc.viewModel = viewModel
//        navigationController.pushViewController(vc, animated: true)
    }
}
