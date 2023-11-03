//
//  Extensions.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 02/11/23.
//

import Foundation
import UIKit

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}

extension Int {
    var stringValue:String {
        return "\(self)"
    }
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

extension UIBarButtonItem {
    @available(iOS 15.0, *)
    static func createBarButtonItem(
        image: UIImage,
        target: Any? = nil,
        action: Selector? = nil
    ) -> UIBarButtonItem {
        let configuration = UIButton.Configuration.navigationBarMaterial()
        let button = UIButton(configuration: configuration)
        button.frame = UIGeneral.materialButton
        if let action = action { button.addTarget(target, action: action, for: .touchUpInside) }
        button.setImage(image, for: .normal)
        return UIBarButtonItem(customView: button)
    }
}

@available(iOS 15.0, *)
extension UIButton.Configuration {
    public static func navigationBarMaterial() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIBackgroundConfiguration.listPlainCell()
        let image = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        background.cornerRadius = 21
        let backgroundEffect = UIBlurEffect(style: .light)
        background.visualEffect = backgroundEffect
        style.background = background
        style.baseForegroundColor = .label
        style.cornerStyle = .capsule
        style.preferredSymbolConfigurationForImage = image
        return style
    }
}
