//
//  ArticleListCell.swift
//  intern_homework
//
//  Created by 渡辺泰平 on 2020/08/09.
//  Copyright © 2020 caraquri. All rights reserved.
//

import Nuke
import UIKit

final class ArticleListCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    func set(_ article: Article) {
        titleTextLabel.text = article.title
        descriptionTextLabel.text = "LGTM: " + String(format: "%3d", article.likesCount) + "   Date: " + article.createdAt.prefix(10)
        
        if let urlString = article.user?.profileImageUrl,
            let url = URL(string: urlString) {
            Nuke.loadImage(with: url, into: userImageView)
        }
    }
    
}
