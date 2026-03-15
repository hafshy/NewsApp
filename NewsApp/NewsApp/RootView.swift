//
//  RootView.swift
//  NewsApp
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import Core
import DesignSystemIOS
import SwiftUI

struct RootView: View {
    @StateObject private var container: AppContainer
    @ObservedObject private var navigator: AppNavigator
    @ObservedObject private var theme: NewsTheme

    init(container: AppContainer) {
        _container = StateObject(wrappedValue: container)
        _navigator = ObservedObject(wrappedValue: container.navigator)
        _theme = ObservedObject(wrappedValue: container.theme)
    }

    var body: some View {
        NavigationStack(path: $navigator.path) {
            container.makeRootView()
                .navigationDestination(for: AppRoute.self) { route in
                    container.destination(for: route)
                        .environmentObject(theme)
                }
        }
        .environmentObject(theme)
        .preferredColorScheme(theme.themeMode.colorScheme)
    }
}
