//
//  StoryboardInstantiable.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/25.
//

import UIKit

protocol StoryboardInstantiable: UIViewController {}

extension StoryboardInstantiable {
    static func instance(storyboard name: String = className) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}

extension NSObject {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    var className: String {
        return type(of: self).className
    }
}
