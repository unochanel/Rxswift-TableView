//
//  LaunchDummyViewController.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/06/01.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

class LaunchDummyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserSession.userDefaults.bool(forKey: UserSession.Key.UserSession) == true {
            self.toArticleView()
        } else {
            self.tologinView()
        }
    }
}

extension  LaunchDummyViewController {
    private func toArticleView() {
        let tabBarC = R.storyboard.tabBarController.instantiateInitialViewController()!
        present(tabBarC, animated: true)
    }

    private func tologinView() {
        let loginVC = R.storyboard.loginViewController.instantiateInitialViewController()!
        present(loginVC, animated: true)
    }
}

