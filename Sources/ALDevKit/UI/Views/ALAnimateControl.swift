//
//  ALAnimateControl.swift
//  
//
//  Created by Alexandr Guzenko on 07.12.2020.
//

import UIKit

open class ALAnimateControl: UIControl {
    public var isEnableAnimate = true
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchBegan()
        touchAnimate(isHighlighted: true)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchEnd()
        touchAnimate(isHighlighted: false)
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchEnd()
        touchAnimate(isHighlighted: false)
    }
    
    open func touchAnimate(isHighlighted: Bool, completion: (() -> Void)? = nil) {
        let transform: CGAffineTransform = isHighlighted ? .init(scaleX: 0.98, y: 0.98) : .identity
        
        ALAnimate.spring(time: 0.35) {
            self.transform = transform
        } completion: {
            completion?()
        }
    }
    
    open func touchBegan() {
        
    }
    
    open func touchEnd() {
        
    }
}
