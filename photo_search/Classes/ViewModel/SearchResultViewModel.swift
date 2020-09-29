//
//  SearchResultViewModel.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/25.
//

import Foundation
import RxSwift
import RxCocoa

class SearchResultViewModel {
    
    let photos: PublishSubject<[PhotoModel]> = PublishSubject()
    let error: PublishSubject<Error> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject<Bool>()
    
    var page: Int {
        get {
            return _page
        }
    }
    var count: Int {
        get {
            return _count
        }
    }
    var isDataOver: Bool {
        get {
            return _isDataOver
        }
    }
    
    fileprivate var _page: Int = 1
    fileprivate var _count: Int = 0
    fileprivate var _isDataOver: Bool = false
    fileprivate var _photo: [PhotoModel] = []
    
    fileprivate let content: String
    fileprivate let perPage: Int
    
    fileprivate let clicked: Observable<(PhotoModel, Int)>
    
    init(content: String, perPage: Int, clicked: Observable<(PhotoModel, Int)>) {
        self.content = content
        self.perPage = perPage
        self.clicked = clicked
        
        _ = self.clicked.subscribe (onNext: { [unowned self] (element: (photo: PhotoModel, row: Int)) in
            if element.photo.isFavourite {
                self.removeFavourite(element.photo)
            } else {
                self.addFavourite(element.photo)
            }
        })
    }
    
    func load() {
        _page = 1
        _count = 0
        _isDataOver = false
        
        loadData { (response) in
            self._photo = response
            self._count = self._photo.count
            self.photos.onNext(self._photo)
        }
    }
    
    func loadMore() {
        _page += 1
        loadData { (response) in
            self._photo.append(contentsOf: response)
            self._count = self._photo.count
            self.photos.onNext(self._photo)
        }
    }
    
    func refresh() {
        load()
    }
    
    func addFavourite(_ object: PhotoModel) {
        CDPhotoStorage.insert(object.id, title: object.title, url: object.url?.absoluteString ?? "")
    }
    
    func removeFavourite(_ object: PhotoModel) {
        if let entity = CDPhotoStorage.fetch(object.id).first {
            CDPhotoStorage.delete(entity)
        }
    }
}

extension SearchResultViewModel {
    fileprivate func loadData(_ success: @escaping (([PhotoModel]) -> Void)) {
        loading.onNext(true)
        
        _ = photoProvider.rx.request(.search(request: PhotoSearchRequest(text: content, per_page: perPage, page: page))).filterSuccessfulStatusCodes().map(PhotoSearchResponse.self).subscribe { (response) in
            
            self._isDataOver = self.page == response.photos.pages
            self.loading.onNext(false)
            
            var list: [PhotoModel] = []
            response.photos.photo.forEach { (element) in
                let model = PhotoModel(id: element.id, url: element.url, title: element.title)
                
                list.append(model)
            }
            
            success(list)
        } onError: { (error) in
            self.loading.onNext(false)
            self.error.onNext(error)
        }
    }
}
