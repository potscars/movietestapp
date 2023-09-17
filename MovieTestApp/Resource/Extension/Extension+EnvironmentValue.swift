//
//  Extension+EnvironmentValue.swift
//  MovieTestApp
//
//  Created by owner on 16/09/2023.
//

import Foundation
import SwiftUI

private struct MainWindowSizeKey: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var mainWindowSize: CGSize {
        get { self[MainWindowSizeKey.self] }
        set { self[MainWindowSizeKey.self] = newValue }
    }
}
