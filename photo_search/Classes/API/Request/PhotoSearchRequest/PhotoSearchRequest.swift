//
//  PhotoSearchRequest.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/24.
//

import Foundation

struct PhotoSearchRequest: Encodable {
    let method: String = "flickr.photos.search"
    let text: String
    let format: String = "json"
    let nojsoncallback: Int = 1
    let api_key: String = "e22c469fa7ee7cf10cf5a8d1c4577f38"
    let per_page: Int
    let page: Int
}
