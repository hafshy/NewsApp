//
//  ThemeManagerProtocol.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 15/03/26.
//

public enum AppThemeMode: String, CaseIterable, Codable, Sendable {
    case system
    case light
    case dark
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
