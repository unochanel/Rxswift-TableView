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
    let result: Observable<Either<Error, [QitaRssGet]>>

    let isRefreshing = BehaviorRelay<Bool>(value: false)
    let cellModels = BehaviorRelay<[ArticleCellViewModel]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    init(qitaRepo: QitaRssGetRepository) {
        result = refreshTrigger
            .flatMap { _ -> Observable<Either<Error, [QitaRssGet]>> in
                qitaRepo.getQiita()
            }
            .share(replay: 1)
    }
}
