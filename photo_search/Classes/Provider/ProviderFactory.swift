//
//  ProviderFactory.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/24.
//

import Foundation
import Moya

struct ProviderFactory {
    static func create<Target: TargetType>() -> MoyaProvider<Target> {
        let plugins = [NetworkLoggerPlugin()]
        
        let isUnitTesting = ProcessInfo.processInfo.environment["isRunUnitTest"] != nil
        
        if isUnitTesting {
            return MoyaProvider<Target>(stubClosure: MoyaProvider.immediatelyStub, plugins: plugins)
        } else {
            return MoyaProvider<Target>(plugins: plugins)
        }
    }
}
