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
    
    init() {
        refreshed$ = refreshTrigger
            .throttle(0.7, latest: false, scheduler: MainScheduler.instance)
            .subscribe( { [weak self]  in
                getQitaAPI()
            })
    }
}

extension class ArticleViewModel {
    private func getQitaAPI() {
        QitaRssAPI().getQitaRss(handler: { [weak self]( QitaRssGet, error)in
            guard let wself = self else { return }
            guard error == nil else {
                //todo: エラーの時の表示
                return
            }
            let qitaRssGet = qitaRssGet else { return }
        })
        wself.sync(models: QitaRssAPI)
    }
    private func sync(models: [QitaRssAPI]) {
        cellModels.value = models.map { ArticleViewModel($0) }
    }
}
