//
//  FavouriteButton.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/27.
//

import Foundation
import RxCocoa
import RxSwift

class FavouriteButton: UIButton {
    fileprivate let favouriteColor = UIColor.red
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = frame.size.height / 2.0
        self.layer.borderColor = favouriteColor.cgColor
        self.layer.borderWidth = 1.0
    }
    
    var isFavourite: Bool = false {
        didSet {
            if isFavourite {
                backgroundColor = favouriteColor
            } else {
                backgroundColor = .clear
            }
        }
    }
}

extension Reactive where Base: FavouriteButton {
    var isFavourite: Binder<Bool> {
        return Binder(self.base) { button, isFavourite in
            button.isFavourite = isFavourite
        }
    }
}
