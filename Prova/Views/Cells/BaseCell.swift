//
//  BaseCell.swift
//  Prova
//
//  Created by Renato Carvalhan on 27/03/18.
//  Copyright © 2018 Renato Carvalhan. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cardLayout(view: UIView) {
        view.layer.cornerRadius = 9
        view.layer.masksToBounds = true
    }
    
    func cardShadow(view: UIView) {
        view.layer.cornerRadius = 9
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 1, height: 3)
        view.layer.shadowRadius = 2
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
    func animateIn() {
        // Animate 3D scale
        self.alpha = 0
        self.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 1
            self.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
    }
}
