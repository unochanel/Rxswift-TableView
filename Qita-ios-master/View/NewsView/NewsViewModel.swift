//
//  NewsViewModel.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/06/04.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class NewsViewModel {
    let newsRefreshTrigger = PublishSubject<Void>()

    let disposeBag = DisposeBag()

    init() {
        newsRefreshTrigger
            .subscribe(onNext: { [weak self] _ in
            })
    }
}
