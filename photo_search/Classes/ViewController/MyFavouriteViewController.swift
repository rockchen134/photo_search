//
//  MyFavouriteViewController.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/25.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class MyFavouriteViewController: UIViewController {
    
    private var collectionView: UICollectionView = {
        let flowLayout = SearchFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        let nib = UINib(nibName: "PhotoCollectionCell", bundle: nil)
        
        collectionView.backgroundColor = .white
        collectionView.register(nib, forCellWithReuseIdentifier: PhotoCollectionCell.reuseID)
        
        return collectionView
    }()
    
    fileprivate var viewModel: MyFavouriteViewModel!
    fileprivate var disposeBag: DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.load()
    }
}

extension MyFavouriteViewController {
    fileprivate func setup() {
        title = NSLocalizedString("my_favourite", comment: "")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(0.0)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(0.0)
        }
    }
    
    fileprivate func bind() {
        let clicked = PublishSubject<(PhotoModel, Int)>()
        viewModel = MyFavouriteViewModel(clicked)
        disposeBag = DisposeBag()

        viewModel.photos.bind(to: collectionView.rx.items(cellIdentifier: PhotoCollectionCell.reuseID, cellType: PhotoCollectionCell.self)) { (row, data, cell)  in
            cell.bind(data: data, row: row, clicked: clicked)
        }.disposed(by: disposeBag)
    }
}
