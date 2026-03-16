//
//  View+AppFont.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 16/03/26.
//

import SwiftUI

private struct AppFontModifier: ViewModifier {
    let style: AppFontStyle
    let weight: Font.Weight?
    let family: AppFontFamily?

    func body(content: Content) -> some View {
        content.font(AppFontProvider.font(style: style, weight: weight, family: family))
    }
}

public extension View {
    func appFont(
        _ style: AppFontStyle,
        weight: Font.Weight? = nil,
        family: AppFontFamily? = nil
    ) -> some View {
        modifier(AppFontModifier(style: style, weight: weight, family: family))
    }
}
