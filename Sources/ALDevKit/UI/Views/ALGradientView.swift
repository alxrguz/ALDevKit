//
//  ALGradientView.swift
//
//  07.08.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import UIKit

public class ALGradientView: UIView {
    
    private var gradientLayer: CAGradientLayer!
    
    public var colors: [UIColor] = [.systemPink, .systemRed] {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var type: CAGradientLayerType = .axial {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var locations: [Double] = [0, 1] {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var startPoint: CGPoint = .init(x: 0, y: 0.5) {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var endPoint: CGPoint = .init(x: 1, y: 0.5) {
        didSet {
            setNeedsLayout()
        }
    }
    
    public override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    public override func layoutSubviews() {
        self.gradientLayer = self.layer as? CAGradientLayer
        self.gradientLayer.colors = colors.map { $0.cgColor }
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
        self.gradientLayer.locations = locations.map { NSNumber(value: $0) }
        self.gradientLayer.type = type
    }
    
    public func animate(duration: TimeInterval, newTopColor: UIColor, newBottomColor: UIColor) {
        let fromColors = self.gradientLayer?.colors
        let toColors: [AnyObject] = [ newTopColor.cgColor, newBottomColor.cgColor]
        self.gradientLayer?.colors = toColors
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = duration
        animation.isRemovedOnCompletion = true
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        self.gradientLayer?.add(animation, forKey:"animateGradient")
    }
}
