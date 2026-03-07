//
//  ArticleDetailPage.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import SwiftUI
import DesignSystemIOS
import DesignSystemCore
import Core

public struct ArticleDetailPage: View {
    @EnvironmentObject var theme: NewsTheme
    let article: NewsArticle
    var coordinator: NewsCoordinator

    public init(article: NewsArticle, coordinator: NewsCoordinator) {
        self.article = article
        self.coordinator = coordinator
    }

    public var body: some View {
        ZStack {
            theme.pageBackground.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    header
                    content
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Category + Breaking
            HStack(spacing: 6) {
                if article.isBreaking {
                    Text("BREAKING")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(theme.core.colors.semantic.errorFG)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                Text(article.category.uppercased())
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .tracking(1.4)
                    .foregroundColor(theme.accent)
            }

            // Headline
            Text(article.headline)
                .font(.system(size: 24, weight: .bold, design: .serif))
                .foregroundColor(theme.textPrimary)
                .lineSpacing(4)

            // Byline
            HStack(spacing: 6) {
                Text(article.author)
                    .font(.system(size: 12, weight: .semibold, design: .monospaced))
                    .foregroundColor(theme.textSecondary)
                Text("·")
                    .foregroundColor(theme.textMuted)
                Text(article.timestamp)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundColor(theme.textMuted)
                Text("·")
                    .foregroundColor(theme.textMuted)
                Text("\(article.readTime) min read")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundColor(theme.textMuted)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.cardSurface)
    }

    // MARK: - Content

    private var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            Divider()
                .background(theme.divider)

            // Summary as lead paragraph
            Text(article.summary)
                .font(.system(size: 16, weight: .medium, design: .serif))
                .foregroundColor(theme.textPrimary)
                .lineSpacing(6)

            Divider()
                .background(theme.divider)

            // Placeholder body — replace with real content from your data layer
            Text("The story continues with additional reporting and analysis from our correspondents around the world. Full coverage including expert commentary and background context is available below.")
                .font(.system(size: 15))
                .foregroundColor(theme.textSecondary)
                .lineSpacing(7)

            Text("Developing details suggest a broader pattern that analysts have been tracking for several months. Sources close to the situation confirmed key elements of the report, though official statements remain pending.")
                .font(.system(size: 15))
                .foregroundColor(theme.textSecondary)
                .lineSpacing(7)
        }
        .padding(20)
    }
}
