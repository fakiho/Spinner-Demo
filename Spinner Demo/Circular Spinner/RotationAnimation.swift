//
//  RotationAnimation.swift
//  Spinner Demo
//
//  Created by Ali FAKIH on 12/05/2022.
//

import Foundation
import QuartzCore

final class RotationAnimation: CABasicAnimation {

    enum Direction: String {
        case x, y, z

        var key: String {
            return "transform.rotation.\(self.rawValue)"
        }
    }

    override init() {
        super.init()
    }

    init(
        direction: Direction,
        fromValue: CGFloat,
        toValue: CGFloat,
        duration: Double,
        repeatCount: Float
    ) {
        super.init()
        self.keyPath = direction.key
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration
        self.repeatCount = repeatCount
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
