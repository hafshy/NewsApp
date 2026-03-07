//
//  AppNavigator.swift
//  NewsApp
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//


import Core
import News
import Combine
import SwiftUI

final class AppNavigator: ObservableObject, Navigating {
    @Published var path = NavigationPath()
    @Published var sheet: (any Routable)? = nil
    
    func push(_ route: any Routable) { path.append(route) }
    func pop() { guard !path.isEmpty else { return }; path.removeLast() }
    func popToRoot() { path = NavigationPath() }
    func present(sheet route: any Routable) { sheet = route }
    func dismiss() { sheet = nil }
}
