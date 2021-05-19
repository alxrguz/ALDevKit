//
//  ActionButton.swift
//  Finance
//
//  Created by Alexandr Guzenko on 24.09.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import UIKit
import SparrowKit

public class ALActionButton: SPDimmedButton {
    
    // MARK: - UIElements
    private lazy var indicatorView = UIActivityIndicatorView()
    
    // MARK: - Public Properties
    public var roundCorners: CGFloat = 14 { didSet { layoutSubviews() } }
    public var isLoading = false {
        didSet {
            loading()
        }
    }
    
    // MARK: - Initializers
    public override init() {
        super.init(frame: .zero)
        applyDefaultAppearance(with: Colorise(content: ALConfiguration.overlayAccentColor ?? UIColor.white, background: ALConfiguration.accentColor ?? UIColor.systemBlue))
        titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        snp.makeConstraints { $0.height.equalTo(50).priority(990) }
        adjustsImageWhenHighlighted = false
        adjustsImageWhenDisabled = false
        imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 3.5)
        titleEdgeInsets = .init(top: 0, left: 3.5, bottom: 0, right: 0)
        
        addSubview(indicatorView)
        indicatorView.do {
            $0.hidesWhenStopped = true
            $0.stopAnimating()
            $0.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIButton
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(radius: roundCorners)
    }
    
    public override func applyDefaultAppearance(with colorise: SPDimmedButton.Colorise? = nil) {
        super.applyDefaultAppearance(with: colorise)
        switch colorise?.title {
            case .custom(let color):
                self.indicatorView.color = color
            case .tint:
                self.indicatorView.color = tintColor
            default:
                self.indicatorView.color = .white
        }
        
    }
    
    // MARK: - Private Methods
    
    private func loading() {
        layer.removeAllAnimations()
        if isLoading {
            isUserInteractionEnabled = false
            ALAnimate.spring(time: 0.4, animate: {
                self.titleLabel?.alpha = 0
            }) {
                self.indicatorView.startAnimating()
            }
        } else {
            isUserInteractionEnabled = true
            indicatorView.stopAnimating()
            ALAnimate.spring(time: 0.4) {
                self.titleLabel?.alpha = 1
            }
        }
    }
}
