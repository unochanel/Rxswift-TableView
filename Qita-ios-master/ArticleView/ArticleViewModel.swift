//
//  ArticleViewModel.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/05/29.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Either
import Alamofire

class ArticleViewModel {
    let refreshTrigger = PublishSubject<Void>()
    let error = PublishSubject<Error>()
    let isRefreshing = BehaviorRelay<Bool>(value: false)
    let cellModels = BehaviorRelay<[ArticleCellViewModel]>(value: [])

    private let disposeBag = DisposeBag()

    init() {
        refreshTrigger
            .subscribe(onNext: { [weak self] _ in
                self?.isRefreshing.accept(true)
                Alamofire.request("https://qiita.com/api/v2/items?page=1&per_page=40", method: .get)
                    .responseJSON{ [weak self] response in
                        self?.isRefreshing.accept(false)
                        
                        let decoder: JSONDecoder = JSONDecoder()
                        do {
                            let models = try decoder.decode([QitaRssGet].self, from: response.data!)
                            self?.cellModels.accept(models.map { ArticleCellViewModel($0) })
                        } catch let error {
                            self?.error.onNext(error)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
