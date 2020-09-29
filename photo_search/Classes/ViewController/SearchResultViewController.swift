//
//  SearchResultViewController.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/25.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import MBProgressHUD

class SearchResultViewController: UIViewController {
    
    static func make(_ content: String, perPage: String) -> SearchResultViewController {
        let vc = SearchResultViewController.instance(storyboard: "Main")
        vc.content = content
        vc.perPage = Int(perPage) ?? 100
        return vc
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchFlowLayout: SearchFlowLayout!
    
    fileprivate let refreshControl = UIRefreshControl()
    
    fileprivate var content: String!
    fileprivate var perPage: Int!
    
    fileprivate var viewModel: SearchResultViewModel!
    fileprivate var disposeBag: DisposeBag!
    fileprivate var waiting = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        bind()
    }
    
    deinit {
        debugPrint(self)
    }
}

extension SearchResultViewController {
    private func setup() {
        let nib = UINib(nibName: "PhotoCollectionCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: PhotoCollectionCell.reuseID)
        collectionView.refreshControl = refreshControl
        
        title = String(format: NSLocalizedString("search_result", comment: ""), content)
    }
    
    private func bind() {
        let clicked = PublishSubject<(PhotoModel, Int)>()
        viewModel = SearchResultViewModel(content: content, perPage: perPage, clicked: clicked)
        disposeBag = DisposeBag()

        viewModel.photos.bind(to: collectionView.rx.items(cellIdentifier: PhotoCollectionCell.reuseID, cellType: PhotoCollectionCell.self)) { (row, data, cell)  in
            cell.bind(data: data, row: row, clicked: clicked.asObserver())
        }.disposed(by: disposeBag)
        
        viewModel.error.subscribe { [unowned self] (_) in
            self.alert(NSLocalizedString("message", comment: ""), message: NSLocalizedString("error_message", comment: "")) {}
        }.disposed(by: disposeBag)
        
        viewModel.loading.subscribe { [unowned self] (event) in
            guard let isLoading = event.element else { return }
            
            self.waiting = isLoading
            
            if isLoading {
                MBProgressHUD.showAdded(to: self.view, animated: true)
            } else {
                self.refreshControl.endRefreshing()
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }.disposed(by: disposeBag)
        
        collectionView.rx.willDisplayCell.subscribe { [unowned self] (cell, indexPath) in
            if indexPath.row == self.viewModel.count - 1 && !self.viewModel.isDataOver && !self.waiting {
                self.viewModel.loadMore()
            }
        }.disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged).subscribe {[unowned self] _ in
            self.viewModel.refresh()
        }.disposed(by: disposeBag)
        
        viewModel.load()
    }
}

extension SearchResultViewController: StoryboardInstantiable {}
