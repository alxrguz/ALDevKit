//
//  RoundImageView.swift
//
//  Created by Alexandr Guzenko on 15.05.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import UIKit

open class ALRoundImageView: UIImageView {
    public init() {
        super.init(frame: .zero)
        clipsToBounds = true
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
