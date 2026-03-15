//
//  AppRoute.swift
//  NewsApp
//
//  Created by Hafshy Yazid Albisthami on 15/03/26.
//

import News

enum AppRoute: Hashable, Identifiable {
    case news(NewsRoute)

    var id: String {
        switch self {
        case .news(let route):
            "news-\(route.id)"
        }
    }
}
