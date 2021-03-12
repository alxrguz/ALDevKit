//
//  ALALRoundView.swift
//  
//
//  Created by Alexandr Guzenko on 17.11.2020.
//

import UIKit
import SparrowKit

open class ALRoundView: UIView {
    public var radius: CGFloat? = nil {
        didSet {
            layoutSubviews()
        }
    }
    
    public init() {
        super.init(frame: .zero)
        clipsToBounds = true
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if let radius = radius {
            roundCorners(radius: radius)
        } else {
            roundCorners()
        }
    }
}
