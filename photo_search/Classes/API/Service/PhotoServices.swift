//
//  PhotoServices.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/24.
//

import Foundation
import Moya

enum PhotoService {
    case search(request: PhotoSearchRequest)
}

extension PhotoService: TargetType {
    var baseURL: URL {
        return URL(string: API.url)!
    }
    
    var path: String {
        switch self {
        case .search:
            return "services/rest/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .search(let request):
            let parameters = try! request.asDictionary()
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    
}
