//
//  AppFeatureProtocol.swift
//  NewsApp
//
//  Created by Hafshy Yazid Albisthami on 15/03/26.
//

import SwiftUI

@MainActor
protocol AppFeatureProtocol {
    func makeRootView(navigator: any AppNavigatorProtocol) -> AnyView
    func destination(for route: AppRoute) -> AnyView?
}
