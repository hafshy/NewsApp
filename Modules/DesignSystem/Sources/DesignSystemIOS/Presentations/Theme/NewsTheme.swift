//
//  NewsTheme.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import SwiftUI
import DesignSystemCore

public final class NewsTheme: ObservableObject {
    
    // The underlying design-token theme. Swap to any CoreTheme variant at runtime.
    @Published public var core: CoreTheme = .default
    /// Main page / list background
    public var pageBackground: Color { core.colors.background.primary }

    /// Card / sheet surface
    public var cardSurface: Color { core.colors.background.elevated }

    /// Subtle section background (category pills, etc.)
    public var subtleSurface: Color { core.colors.background.secondary }

    /// Primary text (headlines, labels)
    public var textPrimary: Color { core.colors.grey.grey900 }

    /// Secondary / meta text (author, timestamp)
    public var textSecondary: Color { core.colors.grey.grey500 }

    /// Muted text (placeholders, captions)
    public var textMuted: Color { core.colors.grey.grey400 }

    /// Brand accent – category badge, breaking indicator, active pill, accent rule
    public var accent: Color { core.colors.primary.primary600 }

    /// Lighter accent for tinted text on dark backgrounds (featured card category label)
    public var accentLight: Color { core.colors.primary.primary100 }

    /// Divider / border lines
    public var divider: Color { core.colors.grey.grey200 }

    /// Subtle card drop shadow
    public var cardShadow: Color { core.colors.grey.grey900.opacity(0.06) }

    /// Breaking-news badge background
    public var breakingBadge: Color { core.colors.semantic.errorFG }

    /// Breaking-news badge foreground (text / dot)
    public var breakingBadgeFG: Color { .white }
    
    public init() {}
}
