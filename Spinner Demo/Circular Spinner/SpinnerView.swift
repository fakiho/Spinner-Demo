//
//  SpinnerView.swift
//  Spinner Demo
//
//  Created by Ali FAKIH on 03/05/2022.
//

import Foundation
import UIKit

final class SpinnerView: UIView {

    private let strokeAnimation: [CABasicAnimation] = [
        StrokeAnimation(
            state: .start,
            beginTime: 0.25,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.8),
        StrokeAnimation(
            state: .end,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.8)
    ]

    private let rotationAnimation: CABasicAnimation = RotationAnimation(direction: .z,
                                                                        fromValue: 0,
                                                                        toValue: .pi * 2,
                                                                        duration: 3,
                                                                        repeatCount: .greatestFiniteMagnitude)



    private let shapeLayer: SpinnerShapeLayer

    init(
        frame: CGRect = .zero,
        strokeColor: UIColor,
        lineWidth: CGFloat
    ) {
        self.shapeLayer = SpinnerShapeLayer(strokeColor: strokeColor, lineWidth: lineWidth)
        super.init(frame: frame)
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshLayers), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        configureShapePath()
    }

    func animate() {
        configureAnimation()
    }

    private func setupUI() {
        backgroundColor = .clear
    }

    private func configureShapePath() {
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        shapeLayer.path = path.cgPath
    }

    @objc
    private func refreshLayers() {
        shapeLayer.removeFromSuperlayer()
        shapeLayer.removeAllAnimations()
        animate()
    }

    private func configureAnimation() {
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = strokeAnimation

        shapeLayer.add(strokeAnimationGroup, forKey: nil)
        layer.addSublayer(shapeLayer)
        layer.add(rotationAnimation, forKey: nil)
    }
}
