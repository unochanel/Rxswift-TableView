//
//  QitaRssAPI.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/05/29.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import Foundation
import Alamofire

class QitaRssAPI{
    func getQitaRss(handler: @escaping ([QitaRssGet]?, Error?) -> Void){
        var qitaRssGet: [QitaRssGet]? = []

        Alamofire.request("https://qiita.com/api/v2/items?page=1&per_page=5", method: .get)
                 .responseJSON{ response in

                let decoder: JSONDecoder = JSONDecoder()
                do {
                    qitaRssGet = try decoder.decode([QitaRssGet].self, from: response.data!)
                } catch _ {
                }
                do{
                    handler(qitaRssGet, nil)
                } catch let error {
                    handler(nil, error)
                }
        }
    }
}

