//
//  PhotoSearchResponse.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/24.
//

import Foundation

struct PhotoSearchResponse: Codable {
    
    struct PhotoDetail: Codable {
        let id: String
        let owner: String
        let secret: String
        let server: String
        let farm: Int
        let title: String
        let ispublic: Int
        let isfriend: Int
        let isfamily: Int
        
        var url: URL? {
            get {
                return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_q.jpg")
            }
        }
    }
    
    struct PhotosData: Codable {
        let page: Int
        let pages: Int
        let perpage: Int
        let total: String
        let photo: [Photo]
    }
    
    let photos: Photos
    let stat: String
}

extension PhotoSearchResponse.PhotoDetail {
    var isFavourite: Bool {
        get {
            guard let _ = CDPhotoStorage.fetch(id).first else {
                return false
            }
            
            return true
        }
    }
}

typealias Photos = PhotoSearchResponse.PhotosData
typealias Photo = PhotoSearchResponse.PhotoDetail
