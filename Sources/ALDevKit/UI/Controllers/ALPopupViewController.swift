//
//  PopupViewController.swift
//  Finance
//
//  Created by Alexandr Guzenko on 01.07.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import UIKit
import SparrowKit

open class ALPopupViewController: UIViewController {
    // MARK: - UI Elements
    public lazy var titleLabel = UILabel()
    public lazy var closeButton = UIButton(type: .close)
    public lazy var contentView = UIView()
    
    // MARK: - Open Proporties
    public var blackoutСolor: UIColor = .init(hex: "#000000", alpha: 0.7) { didSet { setupColors() } }
    public var contentViewColor: UIColor = .init(light: .init(hex: "#ffffff"), dark: .init(hex: "#1C1C1E")) { didSet { setupColors() } }
    public var didDisappear: (() -> Void)?
    
    // MARK: - Life cycle
    public init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAnimate()
    }
}

// MARK: - Handlers
private extension ALPopupViewController {
    @objc func closeTapped() {
        self.closeController()
    }
}

// MARK: - Open Methods
extension ALPopupViewController {
    open func showAnimate() {
        contentView.transform = .init(scaleX: 0.9, y: 0.9)
        view.alpha = 0
        ALAnimate.spring(time: 0.35) {
            self.view.alpha = 1
            self.contentView.transform = .identity
        }
    }
    
    open func hideAnimate(competion: @escaping () -> Void) {
        ALAnimate.spring(time: 0.35, animate: {
            self.view.alpha = 0
            self.contentView.transform = .init(scaleX: 0.9, y: 0.9)
        }) {
            competion()
        }
    }
}

// MARK: - Open Methods
extension ALPopupViewController {
    open func closeController() {
        hideAnimate {
            self.didDisappear?()
            self.dismiss(animated: false, completion: nil)
        }
    }
}

// MARK: - Layout Setup
private extension ALPopupViewController {
    func setupColors() {
        view.backgroundColor = blackoutСolor
        contentView.backgroundColor = contentViewColor
    }
    
    func setupView() {
        setupColors()
        
        contentView.do {
            $0.layer.cornerRadius = 17
            $0.layer.masksToBounds = true
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 17, weight: .semibold)
            $0.adjustsFontSizeToFitWidth = true
            $0.textAlignment = .center
        }
        
        closeButton.do {
            $0.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        }
    }
    
    func setupConstraints() {
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(closeButton)
        
        contentView.snp.makeConstraints {
            $0.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16).priority(999)
            $0.width.lessThanOrEqualTo(485)
            $0.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalTo(titleLabel)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
}
