//
//  SearchFlowLayout.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/25.
//

import UIKit

class SearchFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        
        let width = (UIScreen.main.bounds.size.width - 30.0) / 2.0
        let height = width + 37.0
        
        itemSize = CGSize(width: width, height: height)
        minimumInteritemSpacing = 10.0
        minimumLineSpacing = 10.0
        sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
}
