//
//  AppContainer.swift
//  NewsApp
//
//  Created by Hafshy Yazid Albisthami on 15/03/26.
//

import Combine
import DesignSystemIOS
import SwiftUI
import News

@MainActor
final class AppContainer: ObservableObject {
    var navigator: AppNavigator
    var theme: NewsTheme
    var features: [any AppFeatureProtocol]

    @MainActor
    init() {
        let navigator = AppNavigator()
        let theme = NewsTheme()
        self.navigator = navigator
        self.theme = theme
        self.features = [
            NewsAppFeature(feature: NewsAssembly(themeManager: theme))
        ]
    }

    init(
        navigator: AppNavigator,
        theme: NewsTheme,
        features: [any AppFeatureProtocol]
    ) {
        self.navigator = navigator
        self.theme = theme
        self.features = features
    }

    func makeRootView() -> AnyView {
        guard let rootFeature = features.first else {
            return AnyView(EmptyView())
        }
        return rootFeature.makeRootView(navigator: navigator)
    }

    func destination(for route: AppRoute) -> AnyView {
        for feature in features {
            if let destination = feature.destination(for: route) {
                return destination
            }
        }
        return AnyView(EmptyView())
    }
}
