//
//  ThemeManagerProtocol.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 15/03/26.
//

import SwiftUI

public enum AppThemeMode: String, CaseIterable, Codable, Sendable {
    case system
    case light
    case dark

    public var colorScheme: ColorScheme? {
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

@MainActor
public protocol ThemeManagerProtocol: AnyObject {
    var themeMode: AppThemeMode { get }
    func setThemeMode(_ themeMode: AppThemeMode)
}

public extension ThemeManagerProtocol {
    func useSystemTheme() {
        setThemeMode(.system)
    }

    func useLightTheme() {
        setThemeMode(.light)
    }

    func useDarkTheme() {
        setThemeMode(.dark)
    }
}
