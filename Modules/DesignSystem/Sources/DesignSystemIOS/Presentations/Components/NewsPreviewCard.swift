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
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        AppImage.asset(
                            "ic_verified",
                            contentMode: .fit,
                            tint: Color(token: theme.core.colors.semantic.successFG)
                        )
                        .frame(height: 37)
                        
                        AnimatedOutlinedPercentageText(
                            value: 88,
                            style: .titleMD,
                            fillColor: .white,
                            strokeColor: Color(
                                token: article.trusted < 0.65 ?
                                theme.core.colors.semantic.warningFG : article.trusted < 0.35 ?
                                theme.core.colors.semantic.errorFG :
                                    theme.core.colors.semantic.successFG
                            ),
                            stepDuration: 0.015
                        )
                        .offset(x: -20)
                    }
                    
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
                
                Spacer()
                
                AppImage.remote(
                    URL(string: article.imageURL ?? ""),
                    placeholderSystemName: "newspaper"
                )
                .frame(width: 150, height: 130)
                .cornerRadius(8)
                .clipped()
            }
            .frame(height: 130)
            .padding(8)
            
            Divider()
            
            HStack {
                HStack(alignment: .center, spacing: 6) {
                    AppImage.asset(
                        article.happiness < 0 ? "ic_sent_negative" : article.happiness == 0 ? "ic_sent_neutral" : "ic_sent_positive",
                        tint: Color(
                            token: article.happiness < 0 ? theme.core.colors.semantic.errorFG : article.happiness == 0 ? theme.core.colors.semantic.warningFG : theme.core.colors.semantic.successFG
                        )
                    ).frame(width: 18, height: 18)
                    
                    Text("Sentiment")
                        .appFont(.metaXS, weight: .semibold, family: .montserrat)
                        .foregroundColor(theme.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(1)
                    
                    AppImage.asset(
                        "ic_sent_negative"
                    ).frame(width: 12, height: 12)
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    AppImage.asset(
                        "ic_like",
                        contentMode: .fit
                    ).frame(width: 18, height: 18)
                    
                    AppImage.asset(
                        "ic_comment",
                        contentMode: .fit
                    ).frame(width: 18, height: 18)
                    
                    AppImage.asset(
                        "ic_more",
                        contentMode: .fit
                    )
                    .frame(height: 18)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
        }
        .background(Color(token: theme.core.colors.grey.grey100))
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
