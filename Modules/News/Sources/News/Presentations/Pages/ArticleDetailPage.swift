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

struct ArticleDetailPage: View {
    @EnvironmentObject var theme: NewsTheme
    let article: NewsArticle
    private let themeManager: any ThemeManagerProtocol

    init(article: NewsArticle, themeManager: any ThemeManagerProtocol) {
        self.article = article
        self.themeManager = themeManager
    }

    var body: some View {
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                themeMenu
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            AppImage.remote(
                URL(string: article.imageURL ?? ""),
                placeholderSystemName: "newspaper"
            )
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .clipped()

            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 6) {
                    if article.isBreaking {
                        Text("BREAKING")
                            .appFont(.labelXS, weight: .bold, family: .systemMonospaced)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(theme.breakingBadge)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                    Text(article.category.uppercased())
                        .appFont(.labelXS, weight: .bold, family: .systemMonospaced)
                        .tracking(1.4)
                        .foregroundColor(theme.accent)
                }

                Text(article.headline)
                    .appFont(.detailTitle)
                    .foregroundColor(theme.textPrimary)
                    .lineSpacing(4)

                HStack(spacing: 6) {
                    Text(article.author)
                        .appFont(.bodySM, weight: .semibold, family: .systemMonospaced)
                        .foregroundColor(theme.textSecondary)
                    Text("·")
                        .foregroundColor(theme.textMuted)
                    Text(article.timestamp)
                        .appFont(.bodySM, family: .systemMonospaced)
                        .foregroundColor(theme.textMuted)
                    Text("·")
                        .foregroundColor(theme.textMuted)
                    Text("\(article.readTime) min read")
                        .appFont(.bodySM, family: .systemMonospaced)
                        .foregroundColor(theme.textMuted)
                }
            }
            .padding(20)
        }
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
                .appFont(.detailLead)
                .foregroundColor(theme.textPrimary)
                .lineSpacing(6)

            Divider()
                .background(theme.divider)

            // Placeholder body — replace with real content from your data layer
            Text("The story continues with additional reporting and analysis from our correspondents around the world. Full coverage including expert commentary and background context is available below.")
                .appFont(.bodyMD)
                .foregroundColor(theme.textSecondary)
                .lineSpacing(7)

            Text("Developing details suggest a broader pattern that analysts have been tracking for several months. Sources close to the situation confirmed key elements of the report, though official statements remain pending.")
                .appFont(.bodyMD)
                .foregroundColor(theme.textSecondary)
                .lineSpacing(7)
        }
        .padding(20)
    }

    private var themeMenu: some View {
        Menu("Theme") {
            Button("System") {
                themeManager.useSystemTheme()
            }

            Button("Light") {
                themeManager.useLightTheme()
            }

            Button("Dark") {
                themeManager.useDarkTheme()
            }
        }
    }
}
