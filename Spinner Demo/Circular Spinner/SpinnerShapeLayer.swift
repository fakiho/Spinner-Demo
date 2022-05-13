//
//  SpinnerShapeLayer.swift
//  Spinner Demo
//
//  Created by Ali FAKIH on 03/05/2022.
//

import Foundation
import QuartzCore
import UIKit

/// Draw a circular path
final class SpinnerShapeLayer: CAShapeLayer {

    public init(strokeColor: UIColor, lineWidth: CGFloat) {
        super.init()
        self.strokeColor = strokeColor.cgColor
        self.lineWidth = lineWidth
        fillColor = UIColor.clear.cgColor
        lineCap = .round
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
