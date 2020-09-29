//
//  SearchViewModel.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/24.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    let searchValid: Observable<Bool>

    private let contentValid: Observable<Bool>
    private let perPageValid: Observable<Bool>

    init(content: Observable<String>, perPage: Observable<String>) {
        contentValid = content.map { $0.count >= 1 }.share(replay: 1)
        perPageValid = perPage.map { $0.count >= 1 && Int($0) != nil }.share(replay: 1)
        searchValid = Observable.combineLatest(contentValid, perPageValid) { $0 && $1 }.share(replay: 1)
    }

}
