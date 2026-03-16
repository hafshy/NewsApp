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
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var theme: NewsTheme
    @State private var isLoadingWebContent = true
    let article: NewsArticle
    private let themeManager: any ThemeManagerProtocol

    init(article: NewsArticle, themeManager: any ThemeManagerProtocol) {
        self.article = article
        self.themeManager = themeManager
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            statsStrip
            articleWebView
            footerBar
        }
        .background(theme.pageBackground.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        VStack(spacing: 8) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    AppImage.system("chevron.left", tint: .white)
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(.plain)

                Spacer()

                VStack(spacing: 0) {
                    Text("Oigetit")
                        .appFont(.titleMD, weight: .semibold, family: .montserrat)
                        .foregroundStyle(.white)

                    Text("Your Daily Fact-checked News")
                        .appFont(.labelXS, weight: .medium, family: .montserrat)
                        .foregroundStyle(Color.white.opacity(0.92))
                }

                Spacer()

                Menu {
                    Button("System") {
                        themeManager.useSystemTheme()
                    }

                    Button("Light") {
                        themeManager.useLightTheme()
                    }

                    Button("Dark") {
                        themeManager.useDarkTheme()
                    }
                } label: {
                    AppImage.system("ellipsis.circle", tint: .white)
                        .frame(width: 20, height: 20)
                        .opacity(0.001)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 10)
        }
        .background(Color(hex: "#32B7EF"))
    }
    
    private var trustScoreSection: some View {
        HStack(spacing: 0) {
            AppImage.asset(
                "ic_verified",
                contentMode: .fit,
                tint: trustColor
            )
            .frame(height: 37)

            AnimatedOutlinedPercentageText(
                value: article.trusted.percentageInt,
                style: .titleMD,
                fillColor: Color(token: theme.core.colors.grey.grey100),
                strokeColor: trustColor,
                stepDuration: 0.001
            )
            .offset(x: -8)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Reliability")
                    .appFont(.metaXS, weight: .medium, family: .montserrat)
                    .foregroundColor(theme.textPrimary)
                    .lineLimit(1)
                
                Text("Score")
                    .appFont(.metaXS, weight: .medium, family: .montserrat)
                    .foregroundColor(theme.textPrimary)
                    .lineLimit(1)
            }
            .offset(x: -4)
        }
    }

    private var statsStrip: some View {
        HStack {
            trustScoreSection

            Spacer()

            HStack(spacing: 8) {
                AppImage.asset(sentimentIconName, tint: sentimentColor)
                    .frame(width: 20, height: 20)

                Text("Sentiment")
                    .appFont(.bodyMD, weight: .semibold, family: .montserrat)
                    .foregroundStyle(theme.textPrimary)

                AppImage.asset("ic_question")
                    .frame(width: 12, height: 12)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.white)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(theme.divider)
                .frame(height: 1)
        }
    }

    private var articleWebView: some View {
        ZStack {
            AppWebView(
                url: URL(string: article.url),
                isLoading: $isLoadingWebContent
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)

            if isLoadingWebContent {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(Color(hex: "#32B7EF"))
            }
        }
    }

    private var footerBar: some View {
        HStack {
            footerButton(systemName: "hand.thumbsup")
            Spacer()
            footerButton(systemName: "bubble.left")
            Spacer()
            footerButton(systemName: "square.and.arrow.up")
            Spacer()
            footerButton(systemName: "bookmark")
        }
        .padding(.horizontal, 34)
        .padding(.vertical, 14)
        .background(Color.white)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(theme.divider)
                .frame(height: 1)
        }
    }

    private func footerButton(systemName: String) -> some View {
        Button {
        } label: {
            AppImage.system(systemName, tint: Color(hex: "#4AA7E7"))
                .frame(width: 28, height: 28)
        }
        .buttonStyle(.plain)
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
