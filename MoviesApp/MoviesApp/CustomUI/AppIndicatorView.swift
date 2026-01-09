//
//  AppIndicatorView.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 09.01.26.
//


import UIKit
import SnapKit

final class AppIndicatorView: UIView {
    
    init(color: UIColor? = UIColor(named: "indicatorView"), height: CGFloat = 4) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.clipsToBounds = true
        
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
