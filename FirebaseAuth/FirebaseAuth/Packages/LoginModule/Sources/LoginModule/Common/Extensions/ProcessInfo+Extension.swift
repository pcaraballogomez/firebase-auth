//
//  ProcessInfo+Extension.swift
//  LoginModule
//
//  Created by Pablo Caraballo Gómez on 3/12/25.
//

import Foundation

public extension ProcessInfo {

    enum ExecutionEnvironment {
        case preview
        case simulator
        case device
        case unknown
    }

    /// Returns `true` when running inside a SwiftUI Preview canvas.
    static var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }

    static var executionEnvironment: ExecutionEnvironment {
        guard !ProcessInfo.isPreview else { return .preview }
        #if targetEnvironment(simulator)
        return .simulator
        #else
        return .device
        #endif
    }
}
