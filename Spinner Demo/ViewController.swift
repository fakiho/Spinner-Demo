//
//  ViewController.swift
//  Spinner Demo
//
//  Created by Ali FAKIH on 03/05/2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private enum LoadingIndicatorType {
        case spinner
        case hueSpinner

        var title: String {
            switch self {
            case .spinner:
                return "Spinner"
            case .hueSpinner:
                return "Hue Spinner"
            }
        }
    }

    private var indicatorType = LoadingIndicatorType.spinner
    private let buttonSwitcher = UIButton()
    private var spinnerView = UIView()
    private var hueSpinnerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        overrideUserInterfaceStyle = .light
        configureButtonSwitcher()
        setupIndicator()
    }

    private func configureButtonSwitcher() {
        view.addSubview(buttonSwitcher)
        buttonSwitcher.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
        }
        var configuration = UIButton.Configuration.borderedTinted()
        configuration.baseBackgroundColor = .systemBlue
        configuration.subtitle = "Tap to switch"
        configuration.titleAlignment = .center
        buttonSwitcher.addAction(UIAction(handler: { [weak self] _ in
            self?.toggleSpinner()
        }), for: .touchUpInside)
        buttonSwitcher.configuration = configuration
    }

    private func toggleSpinner() {
        indicatorType = indicatorType == .hueSpinner ? .spinner : .hueSpinner
        setupIndicator()
        buttonSwitcher.setTitle(indicatorType.title, for: .normal)
    }

    private func setupIndicator() {
        switch indicatorType {
        case .spinner:
            addSpinnerView()
        case .hueSpinner:
            addHueSpinnerView()
        }
    }

    private func addSpinnerView() {
        spinnerView.removeFromSuperview()
        hueSpinnerView.removeFromSuperview()
        spinnerView = makeSpinnerView()
        view.addSubview(spinnerView)
        spinnerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }
        (spinnerView as? SpinnerView)?.animate()
    }

    private func makeSpinnerView() -> SpinnerView {
        SpinnerView(strokeColor: .systemRed, lineWidth: 5)
    }

    private func addHueSpinnerView() {
        spinnerView.removeFromSuperview()
        hueSpinnerView.removeFromSuperview()
        hueSpinnerView = makeHueSpinnerView()
        view.addSubview(hueSpinnerView)
        hueSpinnerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }
        (hueSpinnerView as? HueSpinnerView)?.animate()
    }

    private func makeHueSpinnerView() -> HueSpinnerView {
        HueSpinnerView(strokeColor: .systemBlue, lineWidth: 5)
    }
}

