//
//  NewsRouter.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//


import SwiftUI

public enum NewsRouter {

    @MainActor @ViewBuilder
    public static func destination(
        for route: NewsRoute,
        coordinator: NewsCoordinator
    ) -> some View {
        switch route {
        case .list:
            NewsListPage(coordinator: coordinator)

        case .detail(let article):
            ArticleDetailPage(article: article, coordinator: coordinator)
        }
    }
}
