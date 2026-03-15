//
//  NewsAppFeature.swift
//  NewsApp
//
//  Created by Hafshy Yazid Albisthami on 15/03/26.
//

import News
import SwiftUI

@MainActor
struct NewsAppFeature: AppFeatureProtocol {
    private let feature: any NewsFeatureProtocol

    init(feature: any NewsFeatureProtocol) {
        self.feature = feature
    }

    func makeRootView(navigator: any AppNavigatorProtocol) -> AnyView {
        feature.makeRootView { article in
            navigator.push(.news(.detail(article: article)))
        }
    }

    func destination(for route: AppRoute) -> AnyView? {
        guard case .news(let newsRoute) = route else { return nil }
        return feature.makeDestinationView(for: newsRoute)
    }
}
