//
//  QitaRssGet.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/06/04.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Either

protocol QitaRssGetRepository  {
    func getQiita() -> Observable<Either<Error, [QitaRssGet]>>
}
