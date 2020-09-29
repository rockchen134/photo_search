//
//  PhotoModel.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/29.
//

import Foundation

struct PhotoModel {
    let id: String
    var url: URL?
    let title: String
}

extension PhotoModel {
    var isFavourite: Bool {
        get {
            guard let _ = CDPhotoStorage.fetch(id).first else {
                return false
            }
            
            return true
        }
    }
}

