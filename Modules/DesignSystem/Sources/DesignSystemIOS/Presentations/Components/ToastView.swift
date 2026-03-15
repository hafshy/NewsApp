//
//  ToastView.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import SwiftUI
import Core

public struct ToastView: View {
    @EnvironmentObject var theme: NewsTheme
    public let message: String
    
    public init(message: String) {
        self.message = message
    }
    
    public var body: some View {
        HStack(spacing: 10) {
            AppImage.system("exclamationmark.circle.fill", tint: theme.errorForeground)
                .frame(width: 18, height: 18)

            Text(message)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(theme.textPrimary)
                .lineLimit(2)

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(theme.cardSurface)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: theme.cardShadow, radius: 12, x: 0, y: 4)
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}
