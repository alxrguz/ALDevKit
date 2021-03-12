
import UIKit

open class ALAnimateLabel: UILabel {
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
        let alpha: CGFloat = isHighlighted ? 0.7 : 1
        
        ALAnimate.spring(time: 0.35) {
            self.alpha = alpha
        } completion: {
            completion?()
        }
    }
    
    open func touchBegan() {
        
    }
    
    open func touchEnd() {
        
    }
}
