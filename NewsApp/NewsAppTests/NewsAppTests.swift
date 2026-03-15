//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Hafshy Yazid Albisthami on 06/03/26.
//

import Testing
import Foundation
import Core
import DesignSystemIOS
import News
@testable import NewsApp

struct NewsAppTests {

    @MainActor
    @Test func navigatorOpensArticleRoute() {
        let navigator = AppNavigator()
        let article = NewsArticle.samples[0]

        navigator.openArticle(article)

        #expect(navigator.path == [.news(.detail(article: article))])
    }

    @MainActor
    @Test func navigatorUsesDeepLinkParser() {
        let article = NewsArticle.samples[0]
        let navigator = AppNavigator(
            deepLinkParser: DeepLinkParserStub(route: .news(.detail(article: article)))
        )

        navigator.handleDeepLink(URL(string: "newsapp://article")!)

        #expect(navigator.path == [.news(.detail(article: article))])
    }

    @MainActor
    @Test func newsThemeSwitchesThemeMode() {
        let theme = NewsTheme()

        theme.setThemeMode(.dark)
        #expect(theme.themeMode == .dark)
        #expect(theme.themeMode.colorScheme == .dark)

        theme.useLightTheme()
        #expect(theme.themeMode == .light)

        theme.useSystemTheme()
        #expect(theme.themeMode == .system)
        #expect(theme.themeMode.colorScheme == nil)
    }
}

private struct DeepLinkParserStub: AppDeepLinkParserProtocol {
    let route: AppRoute?

    func route(for url: URL) -> AppRoute? {
        _ = url
        return route
    }
}
