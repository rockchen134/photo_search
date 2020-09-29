//
//  SearchViewController.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/24.
//

import UIKit
import RxSwift
import RxCocoa
import TPKeyboardAvoidingSwift

class SearchViewController: UIViewController {
    
    @IBOutlet weak var scrollVIew: UIScrollView!
    @IBOutlet weak var contentField: UITextField!
    @IBOutlet weak var perPageField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    fileprivate var disposeBag: DisposeBag!
    fileprivate var viewModel: SearchViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        bind()
    }
}

extension SearchViewController {
    private func setup() {
        title = NSLocalizedString("search_input_page", comment: "")
        contentField.placeholder = NSLocalizedString("search_content_placehold", comment: "")
        perPageField.placeholder = NSLocalizedString("per_page_placehold", comment: "")
    }
    private func bind() {
        disposeBag = DisposeBag()
        
        viewModel = SearchViewModel(content: contentField.rx.text.orEmpty.asObservable(),
                                    perPage: perPageField.rx.text.orEmpty.asObservable())
        
        viewModel.searchValid.bind(to: searchButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.searchValid.map { (isEnable) in
            isEnable ? UIColor.systemBlue : UIColor.systemGray
        }.bind(to: searchButton.rx.backgroundColor).disposed(by: disposeBag)
        viewModel.searchValid.map { (isEnable) in
            isEnable ? 1.0 : 0.5
        }.bind(to: searchButton.rx.alpha).disposed(by: disposeBag)
        
        searchButton.rx.tap.subscribe { (event) in
            self.showSearchResult()
        }.disposed(by: disposeBag)

    }
    
    private func showSearchResult() {
        guard let content = contentField.text, let perPage = perPageField.text else { return }
        
        let searchResultVC = SearchResultViewController.make(content, perPage: perPage)
        
        navigationController!.pushViewController(searchResultVC, animated: true)
    }
}
