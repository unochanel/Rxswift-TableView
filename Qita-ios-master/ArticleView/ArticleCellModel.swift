//
//  ArticleCellModel.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/05/30.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ArticleCellViewModel {
    let title$: Observable<String>
    let url$: Observable<URL?>
    let profileImageUrl$: Observable<URL?>
    
    public init(_ apiQita: QitaRssGet) {
        title$ = Observable.just(apiQita.title)
        url$ = Observable.just(apiQita.url.toURL())
        profileImageUrl$ = Observable.just(apiQita.user.profileImageUrl.toURL())
    }
}

extension String {
    func toURL() -> URL? {
        return URL(string: self)
    }
}
