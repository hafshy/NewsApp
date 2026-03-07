//
//  NewsCoordinator.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import Core
import Combine

public final class NewsCoordinator: ObservableObject, Navigating {
    private let appNavigator: any Navigating

    public init(appNavigator: any Navigating) {
        self.appNavigator = appNavigator
    }

    public func push(_ route: NewsRoute) {
        appNavigator.push(route)
    }

    public func pop() { appNavigator.pop() }
    public func popToRoot() { appNavigator.popToRoot() }

    public func push(_ route: any Routable) {
        appNavigator.push(route)
    }

    public func present(sheet route: any Routable) {
        appNavigator.present(sheet: route)
    }

    public func dismiss() { appNavigator.dismiss() }
}
