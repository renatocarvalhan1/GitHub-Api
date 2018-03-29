//
//  PullRequestCell.swift
//  Prova
//
//  Created by Renato Carvalhan on 28/03/18.
//  Copyright © 2018 Renato Carvalhan. All rights reserved.
//

import UIKit

class PullRequestCell: BaseCell {

    @IBOutlet var shadowView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var userAvatarView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var openLinkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardLayout(view: cardView)
        cardShadow(view: shadowView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userAvatarView.layer.masksToBounds = true
        userAvatarView.layer.cornerRadius = userAvatarView.frame.height / 2
    }

}
