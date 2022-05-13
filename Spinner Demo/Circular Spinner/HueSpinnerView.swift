//
//  HueSpinnerView.swift
//  Spinner Demo
//
//  Created by Ali FAKIH on 12/05/2022.
//

import UIKit

final class HueSpinnerView: UIView {

    override var layer: CAShapeLayer {
        return super.layer as! CAShapeLayer
    }

    override class var layerClass: AnyClass {
        CAShapeLayer.self
    }

    private let poses: [Pose] = [Pose(0.0, 0.00, 0.7),
                                 Pose(0.6, 0.50, 0.5),
                                 Pose(0.6, 1.00, 0.3),
                                 Pose(0.6, 1.50, 0.1),
                                 Pose(0.2, 1.87, 0.1),
                                 Pose(0.2, 2.25, 0.3),
                                 Pose(0.2, 2.62, 0.5),
                                 Pose(0.2, 3.00, 0.7)]


    private let lineWidth: CGFloat

    init(
        frame: CGRect = .zero,
        strokeColor: UIColor,
        lineWidth: CGFloat
    ) {
        self.lineWidth = lineWidth
        super.init(frame: frame)
        setupUI()
        layer.fillColor = nil
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = lineWidth

        NotificationCenter.default.addObserver(self, selector: #selector(refreshLayers), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    convenience init(
        strokeColor: UIColor = .systemPurple,
        lineWidth: CGFloat = 3
    ) {
        self.init(frame: .zero, strokeColor: strokeColor, lineWidth: lineWidth)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureShapePath()
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        animate()
    }

    func animate() {
        configureAnimation()
    }

    @objc
    private func refreshLayers() {
        layer.removeAllAnimations()
        animate()
    }

    private func setupUI() {
        backgroundColor = .clear
    }

    private func configureShapePath() {
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width / 2)
        layer.path = path.cgPath
    }

    private func configureAnimation() {
        var time: CFTimeInterval = 0
        var allTimes = [CFTimeInterval]()
        var start: CGFloat = 0
        var rotations = [CGFloat]()
        var strokeEnds = [CGFloat]()

        let totalSeconds = poses.reduce(0) { $0 + $1.secondsSincePriorPose }
        poses.forEach { pose in
            time += pose.secondsSincePriorPose
            allTimes.append(time / totalSeconds)
            start = pose.start
            rotations.append(start * 2 * .pi)
            strokeEnds.append(pose.length)
        }
        guard let lastTime = allTimes.last else {
            print("Invalid HueSpinnerView.configureAnimation.allTimes.last")
            return
        }
        allTimes.append(lastTime)
        guard let firstRotation = rotations.first else {
            print("Invalid HueSpinnerView.configureAnimation.rotations.first")
            return
        }
        rotations.append(firstRotation)
        guard let firstStrokeEnd = strokeEnds.first else {
            print("Invalid HueSpinnerView.configureAnimation.strokeEnds.first")
            return
        }
        strokeEnds.append(firstStrokeEnd)

        let times = allTimes as [NSNumber]

        let strokeEndAnimation = frameAnimation(mode: FrameAnimation.Mode.strokeEnd, times: times, values: strokeEnds, duration: totalSeconds)
        layer.add(strokeEndAnimation, forKey: strokeEndAnimation.keyPath)

        
        let rotationAnimation = frameAnimation(mode: FrameAnimation.Mode.rotation, times: times, values: rotations, duration: totalSeconds)
        layer.add(rotationAnimation, forKey: rotationAnimation.keyPath)
        animateStrokeHue(with: totalSeconds * 3)

    }

    private func frameAnimation(mode: FrameAnimation.Mode, times: [NSNumber], values: [CGFloat], duration: CFTimeInterval) -> FrameAnimation {
        FrameAnimation(mode: mode, times: times, values: values, duration: duration)
    }

    private func animateStrokeHue(with duration: CFTimeInterval) {
        let count = 36
        let animation = FrameAnimation(mode: .strokeColor)
        animation.keyTimes = (0 ... count).map { NSNumber(value: CFTimeInterval($0) / CFTimeInterval(count)) }
        animation.values = (0 ... count).map {
            UIColor(hue: CGFloat($0) / CGFloat(count), saturation: 1, brightness: 1, alpha: 1).cgColor
        }
        animation.duration = duration
        animation.calculationMode = .linear
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }
}

private struct Pose {
    let secondsSincePriorPose: CFTimeInterval
    let start: CGFloat
    let length: CGFloat

    init(_ secondsSincePriorPose: CFTimeInterval, _ start: CGFloat, _ length: CGFloat) {
        self.secondsSincePriorPose = secondsSincePriorPose
        self.start = start
        self.length = length
    }
}
