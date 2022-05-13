//
//  FrameAnimation.swift
//  Spinner Demo
//
//  Created by Ali FAKIH on 12/05/2022.
//

import Foundation
import QuartzCore

final class FrameAnimation: CAKeyframeAnimation {

    enum Mode {
        case rotation
        case strokeEnd
        case strokeColor

        var name: String {
            switch self {
            case .rotation:
                return "transform.rotation"
            case .strokeEnd:
                return "strokeEnd"
            case .strokeColor:
                return "strokeColor"
            }
        }
    }

    override init() {
        super.init()
    }

    init(mode: Mode, times: [NSNumber], values: [CGFloat], duration: CFTimeInterval) {
        super.init()
        keyPath = mode.name
        calculationMode = .linear
        repeatCount = .infinity
        keyTimes = times
        self.values = values
        self.duration = duration
    }

    init(mode: Mode) {
        super.init()
        keyPath = mode.name
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
