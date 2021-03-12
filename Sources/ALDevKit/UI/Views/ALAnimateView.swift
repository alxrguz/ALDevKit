//
//  ALAnimateView.swift
//
//  Created by Alexandr Guzenko on 19.05.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import UIKit

open class ALAnimateView: UIView {
    public var isEnableAnimate = true
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        scale(state: true)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        scale(state: false)
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        scale(state: false)
    }
    
    private func scale(state: Bool) {
        guard isEnableAnimate else { return }
        if state == true {
            ALAnimate.spring(time: 0.3, animate: {
                self.transform = .init(scaleX: 0.98, y: 0.98)
            }) {  }
        } else {
            ALAnimate.spring(time: 0.3, animate: {
                self.transform = .identity
            }) {  }
        }
    }
}
