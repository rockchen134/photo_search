//
//  PhotoCollectionCell.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/25.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoCollectionCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var favouriteButton: FavouriteButton!
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    func bind<O>(data: PhotoModel, row: Int, clicked: O) where O: ObserverType, O.Element == (PhotoModel, Int) {
        photoImageView.kf.setImage(with: data.url)
        textLabel.text = data.title
        favouriteButton.isFavourite = data.isFavourite
        
        favouriteButton.rx.tap.map {
            self.favouriteButton.isFavourite = !self.favouriteButton.isFavourite
            return (data, row)
        }.bind(to: clicked).disposed(by: disposeBag)
    }
}
