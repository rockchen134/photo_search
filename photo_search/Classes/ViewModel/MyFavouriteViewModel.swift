//
//  MyFavouriteViewModel.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/25.
//

import Foundation
import RxSwift
import RxCocoa

class MyFavouriteViewModel {
    let photos: PublishSubject<[PhotoModel]> = PublishSubject()
    
    fileprivate var _photos: [PhotoModel] = []
    fileprivate let clicked: Observable<(PhotoModel, Int)>
    
    init(_ clicked: Observable<(PhotoModel, Int)>) {
        self.clicked = clicked
        
        _ = self.clicked.subscribe (onNext: { [unowned self] (element: (photo: PhotoModel, row: Int)) in
            if element.photo.isFavourite {
                if let entity = CDPhotoStorage.fetch(element.photo.id).first {
                    CDPhotoStorage.delete(entity)
                    self.load()
                }
            }
        })
    }
    
    func load() {
        let list = CDPhotoStorage.fetch().map { (photo) -> PhotoModel in
            return PhotoModel(id: photo.id!, url: URL(string: photo.url ?? ""), title: photo.title!)
        }
        _photos.removeAll()
        _photos.append(contentsOf: list)
        photos.onNext(_photos)
    }
}
