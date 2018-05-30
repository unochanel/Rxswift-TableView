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
        //sd_cancelCurrentAnimationImagesLoad()は、urlをイメージに直してくれる
        articleImage.sd_setImage(with: <#T##URL?#>, completed: <#T##SDExternalCompletionBlock?##SDExternalCompletionBlock?##(UIImage?, Error?, SDImageCacheType, URL?) -> Void#>)
    }
    
}
