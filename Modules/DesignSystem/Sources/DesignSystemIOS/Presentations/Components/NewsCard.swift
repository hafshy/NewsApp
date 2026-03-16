//
//  NewsCard.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import SwiftUI
import Core

public struct NewsCard: View {
    public let article: NewsArticle
    @EnvironmentObject var theme: NewsTheme
    @State private var isPressed = false

    public init(article: NewsArticle) {
        self.article = article
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                AppImage.remote(
                    URL(string: article.imageURL ?? ""),
                    placeholderSystemName: "newspaper"
                )
                .frame(height: 180)
                .overlay(
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.32)],
                        startPoint: .top, endPoint: .bottom
                    )
                )

                HStack(spacing: 4) {
                    if article.isBreaking {
                        Circle()
                            .fill(theme.breakingBadgeFG)
                            .frame(width: 6, height: 6)
                    }
                    Text(article.isBreaking
                         ? "BREAKING · \(article.category.uppercased())"
                         : article.category.uppercased())
                        .appFont(.labelXS, family: .systemMonospaced)
                        .tracking(1.4)
                        .foregroundColor(theme.breakingBadgeFG)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(article.isBreaking ? theme.breakingBadge : Color.black.opacity(0.55))
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .padding(14)
            }
            .clipped()
            
            VStack(alignment: .leading, spacing: 10) {

                Text(article.headline)
                    .appFont(.titleMD)
                    .foregroundColor(theme.textPrimary)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)

                Rectangle()
                    .fill(theme.accent)
                    .frame(width: 28, height: 2)

                Text(article.summary)
                    .appFont(.bodyLG)
                    .foregroundColor(theme.textSecondary)
                    .lineSpacing(4)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)

                HStack {
                    Text(article.author)
                        .appFont(.metaXS, weight: .semibold, family: .systemMonospaced)
                        .foregroundColor(theme.textPrimary)
                    Spacer()
                    Text("\(article.timestamp) · \(article.readTime) min read")
                        .appFont(.metaXS, family: .systemMonospaced)
                        .foregroundColor(theme.textMuted)
                }
            }
            .padding(16)
            .background(theme.cardSurface)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: theme.cardShadow, radius: 12, x: 0, y: 4)
        .shadow(color: theme.cardShadow.opacity(0.5), radius: 2, x: 0, y: 1)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { isPressed = $0 }, perform: {})
    }
}


#Preview {
    NewsCard(
        article: .init(
            category: "SPORT",
            imageURL: "https://images.unsplash.com/photo-1547347298-4074fc3086f0?auto=format&fit=crop&w=1200&q=80",
            headline: "Sport title",
            summary: "This is summary of sport news",
            author: "Someone",
            timestamp: "24 Dec 2024",
            readTime: 100,
            isBreaking: false
        )
    )
}
