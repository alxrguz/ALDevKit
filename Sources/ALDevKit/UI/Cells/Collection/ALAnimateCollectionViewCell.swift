//
//  AnimateCollectionViewCell.swift
//  Wallet
//
//  Created by Alexandr Guzenko on 05.01.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import UIKit

open class ALAnimateCollectionViewCell: UICollectionViewCell {
    public var isAnimatable = true
    
    public override var isHighlighted: Bool {
        set {
            super.isHighlighted = newValue
            if isAnimatable { animate(isHighlighted: newValue) }
        }
        
        get { super.isHighlighted }
    }
    
    public func animate(isHighlighted: Bool, completion: (() -> Void)? = nil) {
        let transform: CGAffineTransform = isHighlighted ? .init(scaleX: 0.95, y: 0.95) : .identity
        
        ALAnimate.spring(time: 0.35) {
            self.transform = transform
        } completion: {
            completion?()
        }
    }
}
