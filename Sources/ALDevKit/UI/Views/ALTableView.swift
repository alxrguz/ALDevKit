//
//  ALTableView.swift
//  Finance
//
//  Created by Alexandr Guzenko on 16.10.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import UIKit

open class ALTableView: UITableView {
    
    public init(style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    internal func commonInit() {
        self.delaysContentTouches = false
    }
    
    public override func touchesShouldCancel(in view: UIView) -> Bool {
        #if os(iOS)
        if view is UIControl && !(view is UITextInput) && !(view is UISlider) && !(view is UISwitch) {
            return true
        }
        #endif
        return super.touchesShouldCancel(in: view)
    }
}
