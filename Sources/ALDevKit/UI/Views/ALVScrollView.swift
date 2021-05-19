//
//  HorizontalScrollView + UIView.swift
//  Wallet
//
//  Created by Alexandr Guzenko on 14.12.2019.
//  Copyright © 2019 Alexandr Guzenko. All rights reserved.
//

import UIKit
import SnapKit

public class ALVScrollView: UIScrollView {
    // MARK: UI Elements
    public lazy var contentView = UIView()
    public lazy var backgroundView = UIView()
    
    // MARK: Lifecycle
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        delaysContentTouches = false
        
        addSubview(backgroundView)
        addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIControl && (view is UISwitch) == false { return true }
        return super.touchesShouldCancel(in: view)
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let superview = self.superview else {  return}
        backgroundView.snp.remakeConstraints {
            $0.edges.equalTo(superview)
        }
    }
}
