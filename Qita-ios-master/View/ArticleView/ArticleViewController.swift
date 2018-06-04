//
//  ArticleViewController.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/05/29.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class ArticleViewController: UIViewController {
    
    static func create() -> UIViewController {
        return R.storyboard.articleViewController().instantiateInitialViewController()!
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    private let viewModel = ArticleViewModel(qitaRepo: QitaRssGetRepositoryImpl())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.refreshTrigger.onNext(())
    }
}

extension ArticleViewController {
    private func configure() {
        configureUI()
        configureVM()
        bindToTableView()
    }
    
    private func configureUI() {
        self.title = "Qita記事"
        registerNib()
        refreshControl
            .rx.controlEvent(.valueChanged)
            .bind(to: viewModel.refreshTrigger)
            .disposed(by: disposeBag)
    }

    private func configureVM() {
        viewModel.cellModels.asDriver()
            .drive(tableView.rx.items(cellIdentifier: R.reuseIdentifier.articleViewCell.identifier, cellType: ArticleViewCell.self)) { _, cellModel, cell in
                cell.configure(cm: cellModel)
            }
            .disposed(by: disposeBag)
        
        viewModel.isRefreshing.asDriver()
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        viewModel
            .result
            .subscribe(onNext: { [weak self] either in
                switch either {
                case let .left(error):
                    //todo:エラー時の処理をかく
                    break
                case let .right(response):
                    self?.viewModel.cellModels.accept(response.map { ArticleCellViewModel($0) })
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindToTableView() {
        tableView.addSubview(refreshControl)

        tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .flatMap({ [weak self] indexPath -> Observable<URL?> in
                guard let wself = self else { return Observable.empty() }
                return wself.viewModel.cellModels.value[indexPath.row].url$
            })
            .subscribe(onNext: {[weak self] url in
                guard let wself = self else { return }
                guard let u = url else {
                    assertionFailure("not exist url")
                    return
                }
                let safariViewController = SFSafariViewController(url: u)
                self?.present(safariViewController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}

extension ArticleViewController: UITableViewDelegate {
    func tableView(_: UITableView, editingStyleForRowAt _: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 80
    }
}

extension ArticleViewController {
    private func registerNib() {
        let nib = R.nib.articleViewCell()
        tableView.register(
            nib,
            forCellReuseIdentifier: R.reuseIdentifier.articleViewCell.identifier
        )
    }
}
