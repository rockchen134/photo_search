//
//  API.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/24.
//

import Foundation

/// API URL
#if DEBUG
struct API {
    static let url = "https://www.flickr.com"
}
#else
struct API {
    static let url = "https://www.flickr.com"
}
#endif
