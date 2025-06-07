//
//  UILabel+Extensions.swift
//  MovieQuiz
//
//  Created by Razumov Pavel on 06.06.2025.
//

import UIKit

extension UILabel {
    enum AppFont: String {
        case ysDisplayBold = "YSDisplay-Bold"
        case ysDisplayMedium = "YSDisplay-Medium"
        
        var value: String {
            switch self {
            case .ysDisplayBold:
                return "YSDisplay-Bold"
            case .ysDisplayMedium:
                return "YSDisplay-Medium"
            }
        }
    }
    
    convenience init(
        text: String? = nil,
        font: AppFont,
        size: CGFloat = 17,
        color: UIColor = .ypBlack,
        alignment: NSTextAlignment = .left,
        numberOfLines: Int = 0
    ) {
        self.init()
        self.text = text
        self.font = UIFont(name: font.value, size: size)
        self.textColor = color
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
}

