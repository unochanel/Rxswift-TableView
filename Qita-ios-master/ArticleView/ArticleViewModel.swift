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


class ArticleViewModel {
    private let bag = DisposeBag()
    let refreshTrigger = PublishSubject<Void>()
    public var apiQita = PublishSubject<[QitaRssGet]?>()
    public var apiError = PublishSubject<Error?>()
    let cellModels = Variable<[ArticleCellViewModel]>([])

    init() {
        refreshTrigger
            .throttle(0.7, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let wself = self else { return }
                QitaRssAPI().getQitaRss()
                
                let _ = Observable
                    .combineLatest(wself.apiQita,wself.apiError)
                    .subscribe(onNext: {[weak self] qita, error in
                        guard let wself = self else { return }
                        guard error == nil else {
                            //ToDo:ここにエラーの処理を書く
                            return
                            
                        }
                        guard let qita = qita else {
                            //ToDo:ここにエラーの処理を書く
                            return
                        }
                        wself.sync(models: qita)
                    })
            })
    }
}

extension ArticleViewModel {
    func sync (models: [QitaRssGet]) {
        cellModels.value = models.map { ArticleCellViewModel($0) }
    }
}
