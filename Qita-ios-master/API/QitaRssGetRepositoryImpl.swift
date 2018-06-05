//
//  sss.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/06/04.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Either
import Alamofire

public final class QitaRssGetRepositoryImpl: QitaRssGetRepository {
    func getQiita() -> Observable<Either<Error, [QitaRssGet]>> {
        //observableのcreateを使うと、引数にはdisposableを使う
        return Observable.create { [weak self] (observable) -> Disposable in
            Alamofire.request("https://qiita.com/api/v2/items?page=1&per_page=40", method: .get)
                .responseJSON { response in
                    let decoder: JSONDecoder = JSONDecoder()
                    let models = try! decoder.decode([QitaRssGet].self, from: response.data!)
                    observable.onNext(Either.right(models))
                    observable.onCompleted()
            }
            return Disposables.create()
            }
            .catchError { (error) -> Observable<Either<Error, [QitaRssGet]>> in
                Observable.of(Either.left(error))
        }
    }
}
