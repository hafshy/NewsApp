//
//  NewsPreviewCard.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 16/03/26.
//

import SwiftUI
import Core

public struct NewsPreviewCard: View {
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
                    Circle()
                        .fill(theme.breakingBadgeFG)
                        .frame(width: 6, height: 6)
                    Text("BREAKING · \(article.feed.uppercased())")
                        .appFont(.labelXS, family: .systemMonospaced)
                        .tracking(1.4)
                        .foregroundColor(theme.breakingBadgeFG)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(theme.breakingBadge)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .padding(14)
            }
            .clipped()

            VStack(alignment: .leading, spacing: 10) {
                Text(article.title)
                    .appFont(.titleMD)
                    .foregroundColor(theme.textPrimary)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)

                Rectangle()
                    .fill(theme.accent)
                    .frame(width: 28, height: 2)

                Text("Trust \(Int((article.trusted * 100).rounded()))% • Mood \(article.happiness > 0 ? "+\(article.happiness)" : "\(article.happiness)")")
                    .appFont(.bodyLG)
                    .foregroundColor(theme.textSecondary)
                    .lineSpacing(4)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)

                HStack {
                    Text(article.feed)
                        .appFont(.metaXS, weight: .semibold, family: .systemMonospaced)
                        .foregroundColor(theme.textPrimary)
                    Spacer()
                    Text(article.pubDate)
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
    NewsPreviewCard(
        article: .init(
            id: 1,
            title: "Sport title",
            pubDate: "2026-03-16 12:00:00",
            url: "https://example.com/news/1",
            feed: "Sports Feed",
            imageURL: "https://images.unsplash.com/photo-1547347298-4074fc3086f0?auto=format&fit=crop&w=1200&q=80",
            happiness: 19,
            trusted: 0.8
        )
    )
    .padding()
    .environmentObject(NewsTheme())
}
