//
//  UIWindowScene+Extension.swift
//  LoginModule
//
//  Created by Pablo Caraballo Gómez on 9/12/25.
//

import SwiftUI

extension UIWindowScene {
    var keyWindow: UIWindow? { windows.first { $0.isKeyWindow } }
}
