//
//  LoginViewController.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/06/01.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension LoginViewController {
    func configure() {
        configureButton()
    }

    func configureButton() {
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                self.presentArticleViewController()
            } else {
                //todo:AlertViewControllerを使う。
                print("errorです。")
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
}

extension LoginViewController {
    private func presentArticleViewController() {
        UserSession.userDefaults.set(true, forKey: UserSession.Key.UserSession)
        let articleVC = R.storyboard.articleViewController.instantiateInitialViewController()!
        present(articleVC, animated: true)
    }
}
