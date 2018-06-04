//
//  NewsViewController.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/06/04.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsViewController: UIViewController {
    static func create() -> UIViewController {
        return R.storyboard.newsViewController().instantiateInitialViewController()!
    }

    private let disposedBag = DisposeBag()
    private var viewModel = NewsViewModel()
    @IBOutlet weak var newsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension NewsViewController {
    private func configure() {
        configureUI()
    }

    private func configureUI(){
        title = "CoinNews"
        registerNib()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, editingStyleForRowAt _: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsViewCell", for: indexPath)
        return cell
    }
}

extension NewsViewController {
    private func registerNib() {
        let nib = R.nib.newsViewCell()
        newsTableView.register(
            nib,
            forCellReuseIdentifier: R.reuseIdentifier.newsViewCell.identifier
        )
    }
}
