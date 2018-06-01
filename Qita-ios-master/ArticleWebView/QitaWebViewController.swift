//
//  QitaWebViewController.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/05/31.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WebKit

class QitaWebViewController: UIViewController {
    private let disposedBag = DisposeBag()
    private var wkWebView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
