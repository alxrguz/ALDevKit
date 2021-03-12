//
//  ALProgressBar.swift
//  Finance
//
//  Created by Alexandr Guzenko on 19.11.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import UIKit
import SnapKit

final public class ALProgressBar: UIView {
    
    // MARK: - UI Elements
    
    lazy var progressView = UIView()
    public private(set) var progress: Float = 0
    
    // MARK: - Open Proporties
    
    public var cornersRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornersRadius
            progressView.layer.cornerRadius = cornersRadius
        }
    }
    
    public var progressTintColor: UIColor? = .systemBlue {
        didSet {
            ALAnimate.spring(time: 0.4) {
                self.progressView.backgroundColor = self.progressTintColor
            }
        }
    }
    
    public var trackTintColor = UIColor.gray.withAlphaComponent(0.3) {
        didSet {
            ALAnimate.spring(time: 0.4) {
                self.backgroundColor = self.trackTintColor
            }
        }
    }
    
    // MARK: - Private Proporties
    private var widthConstraint: Constraint?
    
    // MARK: - Life cycle
    public init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Open Methods
public extension ALProgressBar {
    func setProgress(value: Float, animated: Bool) {
        let value = abs(value > 1 ? 1 : value)
        
        progress = value
        
        progressView.snp.remakeConstraints {
            $0.width.equalTo(self).multipliedBy(value)
            $0.leading.top.bottom.equalToSuperview()
        }
        if animated {
            ALAnimate.spring(time: 1) { self.layoutIfNeeded() }
        } else {
            layoutIfNeeded()
        }
    }
}

// MARK: - Layout Setup
private extension ALProgressBar {
    func setupColors() {
        self.backgroundColor = trackTintColor
        progressView.backgroundColor = progressTintColor
    }
    
    func setupView() {
        setupColors()
    }
    
    func setupConstraints() {
        addSubview(progressView)
        
        self.snp.makeConstraints {
            $0.height.equalTo(4).priority(.low)
        }
        
        progressView.snp.makeConstraints {
            $0.width.equalTo(self).multipliedBy(0)
            $0.leading.top.bottom.equalToSuperview()
        }
    }
}
