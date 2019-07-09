//
//  Application.swift
//  MBCleanSwiftExample
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation
import MBDomain
import MBNetworkPlatform

final class Application {
    static let shared = Application()
    
    private let networkUseCaseProvider: MBNetworkPlatform.UseCaseProvider
    
    private init() {
        self.networkUseCaseProvider = MBNetworkPlatform.UseCaseProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let networkNavigationController = UINavigationController()
        networkNavigationController.tabBarItem = UITabBarItem(title: "Network",
                                                              image: nil,
                                                              selectedImage: nil)
        let networkNavigator = DefaultQuestionsNavigator(services: networkUseCaseProvider,
                                                     navigationController: networkNavigationController,
                                                     storyBoard: storyboard)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            networkNavigationController
        ]
        window.rootViewController = tabBarController
        
        networkNavigator.toQuestions()
    }
}
