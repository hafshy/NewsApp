//
//  AppThemeProtocol.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 15/03/26.
//

import Core
import SwiftUI
import DesignSystemCore

@MainActor
public protocol AppThemeProtocol: ThemeManagerProtocol {
    var core: CoreTheme { get }
    var pageBackground: Color { get }
    var cardSurface: Color { get }
    var subtleSurface: Color { get }
    var textPrimary: Color { get }
    var textSecondary: Color { get }
    var textMuted: Color { get }
    var accent: Color { get }
    var accentLight: Color { get }
    var divider: Color { get }
    var cardShadow: Color { get }
    var breakingBadge: Color { get }
    var breakingBadgeFG: Color { get }
}
