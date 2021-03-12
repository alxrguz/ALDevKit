//
//  ALCollectionView.swift
//  
//
//  Created by Alexandr Guzenko on 17.11.2020.
//

import UIKit

open class ALCollectionView: UICollectionView {
    
    public init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        commonInit()
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    internal func commonInit() {
        self.delaysContentTouches = false
        backgroundColor = .clear
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
