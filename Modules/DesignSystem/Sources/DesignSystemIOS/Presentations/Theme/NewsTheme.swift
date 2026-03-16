//
//  NewsTheme.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import Core
import Foundation
import SwiftUI
import DesignSystemCore

@MainActor
public final class NewsTheme: ObservableObject, AppThemeProtocol {
    private enum Storage {
        static let themeModeKey = "app_theme_mode"
    }
    
    // The underlying design-token theme. Swap to any CoreTheme variant at runtime.
    @Published public var core: CoreTheme = .default
    @Published public private(set) var themeMode: AppThemeMode = .system
    /// Main page / list background
    public var pageBackground: Color { Color(token: core.colors.background.primary) }

    /// Card / sheet surface
    public var cardSurface: Color { Color(token: core.colors.background.elevated) }

    /// Subtle section background (category pills, etc.)
    public var subtleSurface: Color { Color(token: core.colors.background.secondary) }

    /// Primary text (headlines, labels)
    public var textPrimary: Color { Color(token: core.colors.grey.grey900) }

    /// Secondary / meta text (author, timestamp)
    public var textSecondary: Color { Color(token: core.colors.grey.grey500) }

    /// Muted text (placeholders, captions)
    public var textMuted: Color { Color(token: core.colors.grey.grey400) }

    /// Brand accent – category badge, breaking indicator, active pill, accent rule
    public var accent: Color { Color(token: core.colors.primary.primary600) }

    /// Lighter accent for tinted text on dark backgrounds (featured card category label)
    public var accentLight: Color { Color(token: core.colors.primary.primary100) }

    /// Divider / border lines
    public var divider: Color { Color(token: core.colors.grey.grey200) }

    /// Subtle card drop shadow
    public var cardShadow: Color { Color(token: core.colors.grey.grey900).opacity(0.06) }

    /// Breaking-news badge background
    public var breakingBadge: Color { Color(token: core.colors.semantic.errorFG) }

    /// Breaking-news badge foreground (text / dot)
    public var breakingBadgeFG: Color { .white }
    public var errorForeground: Color { Color(token: core.colors.semantic.errorFG) }
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.themeMode = Self.loadThemeMode(from: userDefaults)
    }

    public func setThemeMode(_ themeMode: AppThemeMode) {
        self.themeMode = themeMode
        userDefaults.set(themeMode.rawValue, forKey: Storage.themeModeKey)
    }

    private static func loadThemeMode(from userDefaults: UserDefaults) -> AppThemeMode {
        guard let rawValue = userDefaults.string(forKey: Storage.themeModeKey),
              let themeMode = AppThemeMode(rawValue: rawValue) else {
            return .system
        }

        return themeMode
    }
}
