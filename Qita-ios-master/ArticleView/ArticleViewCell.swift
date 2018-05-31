//
//  ArticleViewCell.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/05/29.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ArticleViewCell: UITableViewCell {
    private var bag = DisposeBag()
    
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    override func prepareForReuse() {
        articleImage.sd_cancelCurrentAnimationImagesLoad()
        articleImage.image = nil
    }
    
    func configure(cm: ArticleCellViewModel) {
        cm
            .title$
            .bind(to: articleLabel.rx.text)
            .disposed(by: bag)
        cm
            .profileImageUrl$
            .subscribe(onNext: { [weak self] url in
                guard let wself = self else { return }
                wself.articleImage.sd_setImage(
                    with: url,
                    completed: { image, error, cacheType, imageURL in
                        
                })
            })
            .disposed(by: bag)
    }
}
