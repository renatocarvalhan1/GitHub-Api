//
//  RepositoryCell.swift
//  Prova
//
//  Created by Renato Carvalhan on 27/03/18.
//  Copyright © 2018 Renato Carvalhan. All rights reserved.
//

import UIKit

class RepositoryCell: BaseCell {

    @IBOutlet var shadowView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var ownerAvatarView: UIImageView!
    @IBOutlet var ownerNameLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var forksCountLabel: UILabel!
    @IBOutlet var starsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardLayout(view: cardView)
        cardShadow(view: shadowView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ownerAvatarView.layer.masksToBounds = true
        ownerAvatarView.layer.cornerRadius = ownerAvatarView.frame.height / 2
    }
}
