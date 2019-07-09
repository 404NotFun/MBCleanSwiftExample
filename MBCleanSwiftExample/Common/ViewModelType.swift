//
//  ViewModelType.swift
//  MBCleanSwiftExample
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
