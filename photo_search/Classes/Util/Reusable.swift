//
//  Reusable.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/27.
//

import UIKit

protocol Reusable {
    static var reuseID: String { get }
}

extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: Reusable {}
