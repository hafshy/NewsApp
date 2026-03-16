//
//  NewsAssembly.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 15/03/26.
//

import Core
import Swinject
import SwiftUI

public protocol NewsFeatureProtocol {
    @MainActor func makeRootView(onSelectArticle: @escaping (NewsArticle) -> Void) -> AnyView
    @MainActor func makeDestinationView(for route: NewsRoute) -> AnyView
}

public final class NewsAssembly: NewsFeatureProtocol {
    private let container: Container
    private let themeManager: any ThemeManagerProtocol

    public init(themeManager: any ThemeManagerProtocol) {
        self.container = Container()
        self.themeManager = themeManager
        registerDependencies()
    }

    init(container: Container, themeManager: any ThemeManagerProtocol) {
        self.container = container
        self.themeManager = themeManager
        registerDependencies()
    }

    @MainActor
    public func makeRootView(onSelectArticle: @escaping (NewsArticle) -> Void) -> AnyView {
        AnyView(
            NewsListPage(
            viewModel: NewsListViewModel(
                fetchArticles: resolve(FetchArticlesUseCaseProtocol.self)
            ),
            themeManager: themeManager,
            onSelectArticle: onSelectArticle
        )
        )
    }

    @MainActor
    public func makeDestinationView(for route: NewsRoute) -> AnyView {
        switch route {
        case .detail(let article):
            AnyView(ArticleDetailPage(article: article, themeManager: themeManager))
        }
    }

    private func registerDependencies() {
        container.register(NewsRemoteServiceProtocol.self) { _ in
            NewsRemoteService(httpClient: self.makeMockBreakingNewsClient())
        }

        container.register(NewsLocalServiceProtocol.self) { _ in
            NewsLocalService()
        }

        container.register(NewsRepositoryProtocol.self) { resolver in
            NewsRepository(
                remoteService: self.resolve(NewsRemoteServiceProtocol.self, resolver: resolver),
                service: self.resolve(NewsLocalServiceProtocol.self, resolver: resolver)
            )
        }

        container.register(FetchArticlesUseCaseProtocol.self) { resolver in
            FetchArticlesUseCase(repository: self.resolve(NewsRepositoryProtocol.self, resolver: resolver))
        }
    }

    private func resolve<Service>(
        _ serviceType: Service.Type,
        resolver: Resolver? = nil
    ) -> Service {
        guard let service = (resolver ?? container).resolve(serviceType) else {
            fatalError("Failed to resolve \(serviceType)")
        }
        return service
    }

    private func makeMockBreakingNewsClient() -> any HttpClientProtocol {
        let request = MockRequest(
            url: "https://api.oigetit.com/V3/GetBreakingNews",
            method: .get,
            headers: [:],
            queryParams: [
                "category": "0",
                "filter": "all",
                "language": "EN",
                "region": ""
            ]
        )

        return MockHttpClient(
            responses: [
                request: MockResponse(data: Self.loadBreakingNewsResponseData())
            ]
        )
    }

    private static func loadBreakingNewsResponseData() -> Data {
        guard let url = Bundle.module.url(forResource: "response", withExtension: "json") else {
            fatalError("Missing response.json in News resources")
        }

        do {
            return try Data(contentsOf: url)
        } catch {
            fatalError("Failed to load response.json: \(error.localizedDescription)")
        }
    }
}
