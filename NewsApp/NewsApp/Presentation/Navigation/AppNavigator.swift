//
//  AppNavigator.swift
//  NewsApp
//
//  Created by Hafshy Yazid Albisthami on 15/03/26.
//

import Core
import Combine
import Foundation
import News

protocol AppDeepLinkParserProtocol {
    func route(for url: URL) -> AppRoute?
}

struct AppDeepLinkParser: AppDeepLinkParserProtocol {
    func route(for url: URL) -> AppRoute? {
        _ = url
        return nil
    }
}

@MainActor
protocol AppNavigatorProtocol: ObservableObject {
    var path: [AppRoute] { get }
    func push(_ route: AppRoute)
    func pop()
    func popToRoot()
    func openArticle(_ article: NewsArticle)
    func handleDeepLink(_ url: URL)
}

@MainActor
final class AppNavigator: AppNavigatorProtocol {
    @Published var path: [AppRoute] = []
    private let deepLinkParser: any AppDeepLinkParserProtocol

    init() {
        self.deepLinkParser = AppDeepLinkParser()
    }

    init(deepLinkParser: any AppDeepLinkParserProtocol) {
        self.deepLinkParser = deepLinkParser
    }

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        guard path.isEmpty == false else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }

    func openArticle(_ article: NewsArticle) {
        push(.news(.detail(article: article)))
    }

    func handleDeepLink(_ url: URL) {
        guard let route = deepLinkParser.route(for: url) else { return }
        path = [route]
    }
}
