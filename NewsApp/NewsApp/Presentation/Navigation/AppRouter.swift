//
//  AppRouter.swift
//  NewsApp
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import Core
import News
import SwiftUI

enum AppRouter {
    @ViewBuilder
    static func destination(
        for route: any Routable,
        newsCoord: NewsCoordinator
    ) -> some View {
        if let route = route as? NewsRoute {
            NewsRouter.destination(for: route, coordinator: newsCoord)
        } else {
            EmptyView()
        }
    }
}
