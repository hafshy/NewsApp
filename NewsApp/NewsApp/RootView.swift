//
//  RootView.swift
//  NewsApp
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import Core
import DesignSystemCore
import DesignSystemIOS
import SwiftUI
import News

struct RootView: View {
    @StateObject private var navigator = AppNavigator()
    @StateObject private var theme = NewsTheme()

    private var newsCoord: NewsCoordinator

    init() {
        let nav = AppNavigator()
        _navigator = StateObject(wrappedValue: nav)
        _theme = StateObject(wrappedValue: NewsTheme())
        newsCoord = NewsCoordinator(appNavigator: nav)
    }

    var body: some View {
        NavigationStack(path: $navigator.path) {
            NewsListPage(coordinator: newsCoord)
                .navigationDestination(for: NewsRoute.self) { route in
                    AppRouter.destination(
                        for: route,
                        newsCoord: newsCoord
                    )
                    .environmentObject(theme)
                }
        }
        .environmentObject(theme)
    }
}
