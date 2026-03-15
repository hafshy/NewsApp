//
//  AppThemeMode+SwiftUI.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 15/03/26.
//

import Core
import SwiftUI

public extension AppThemeMode {
    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            nil
        case .light:
            .light
        case .dark:
            .dark
        }
    }
}
