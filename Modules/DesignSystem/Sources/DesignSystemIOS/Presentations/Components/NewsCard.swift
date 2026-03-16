//
//  NewsCard.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import SwiftUI
import Core

public struct NewsCard: View {
    private enum Layout {
        static let contentHeight: CGFloat = 130
        static let thumbnailWidth: CGFloat = 150
        static let thumbnailHeight: CGFloat = 130
        static let verificationIconHeight: CGFloat = 37
        static let sentimentIconSize: CGFloat = 18
        static let infoIconSize: CGFloat = 12
        static let actionIconSize: CGFloat = 18
    }

    public let article: NewsArticle
    @EnvironmentObject var theme: NewsTheme
    @State private var isPressed = false

    public init(article: NewsArticle) {
        self.article = article
    }

    public var body: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            contentSection
                .frame(height: Layout.contentHeight)
            .padding(8)

            Divider()

            footerSection
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
        }
        .background(Color(token: theme.core.colors.grey.grey100))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: theme.cardShadow, radius: 12, x: 0, y: 4)
        .shadow(color: theme.cardShadow.opacity(0.5), radius: 2, x: 0, y: 1)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { isPressed = $0 }, perform: {})
    }

    private var contentSection: some View {
        HStack(spacing: 20) {
            textContentSection

            Spacer()

            articleImage
        }
    }

    private var textContentSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            trustScoreSection

            Text(article.title)
                .appFont(.detailLead, family: .montserrat)
                .foregroundColor(theme.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(3)

            Spacer()

            Text(article.feed)
                .appFont(.labelXS, weight: .regular, family: .montserrat)
                .foregroundColor(theme.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(1)
        }
    }

    private var trustScoreSection: some View {
        HStack {
            AppImage.asset(
                "ic_verified",
                contentMode: .fit,
                tint: trustColor
            )
            .frame(height: Layout.verificationIconHeight)

            AnimatedOutlinedPercentageText(
                value: article.trusted.percentageInt,
                style: .titleMD,
                fillColor: Color(token: theme.core.colors.grey.grey100),
                strokeColor: trustColor,
                stepDuration: 0.001
            )
            .offset(x: -20)
        }
    }

    private var articleImage: some View {
        AppImage.remote(
            URL(string: article.imageURL ?? ""),
            placeholderSystemName: "newspaper"
        )
        .frame(width: Layout.thumbnailWidth, height: Layout.thumbnailHeight)
        .cornerRadius(8)
        .clipped()
    }

    private var footerSection: some View {
        HStack {
            sentimentSection

            Spacer()

            actionSection
        }
    }

    private var sentimentSection: some View {
        HStack(alignment: .center, spacing: 6) {
            AppImage.asset(
                sentimentIconName,
                tint: sentimentColor
            )
            .frame(width: Layout.sentimentIconSize, height: Layout.sentimentIconSize)

            Text("Sentiment")
                .appFont(.metaXS, weight: .semibold, family: .montserrat)
                .foregroundColor(theme.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(1)

            AppImage.asset("ic_question")
                .frame(width: Layout.infoIconSize, height: Layout.infoIconSize)
        }
    }

    private var actionSection: some View {
        HStack(spacing: 12) {
            actionIcon("ic_like")
            actionIcon("ic_comment")

            AppImage.asset("ic_more", contentMode: .fit)
                .frame(height: Layout.actionIconSize)
        }
    }

    private func actionIcon(_ name: String) -> some View {
        AppImage.asset(name, contentMode: .fit)
            .frame(width: Layout.actionIconSize, height: Layout.actionIconSize)
    }

    private var trustColor: Color {
        if article.trusted < 0.35 {
            return Color(token: theme.core.colors.semantic.errorFG)
        }

        if article.trusted < 0.65 {
            return Color(token: theme.core.colors.semantic.warningFG)
        }

        return Color(token: theme.core.colors.semantic.successFG)
    }

    private var sentimentIconName: String {
        if article.happiness < 0 {
            return "ic_sent_negative"
        }

        if article.happiness == 0 {
            return "ic_sent_neutral"
        }

        return "ic_sent_positive"
    }

    private var sentimentColor: Color {
        if article.happiness < 0 {
            return Color(token: theme.core.colors.semantic.errorFG)
        }

        if article.happiness == 0 {
            return Color(token: theme.core.colors.semantic.warningFG)
        }

        return Color(token: theme.core.colors.semantic.successFG)
    }
}

#Preview {
    NewsCard(
        article: .init(
            id: 1,
            title: "Sport title",
            pubDate: "2026-03-16 12:00:00",
            url: "https://example.com/news/1",
            feed: "Sports Feed",
            imageURL: "https://images.unsplash.com/photo-1547347298-4074fc3086f0?auto=format&fit=crop&w=1200&q=80",
            happiness: 8,
            trusted: 0.86
        )
    )
    .padding()
    .environmentObject(NewsTheme())
}
