//
//  AppRoute.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import News
import Core

public enum AppRoute: Routable {
    case news(NewsRoute)

    public var id: String {
        switch self {
        case .news(let r): return "news-\(r.id)"
        }
    }
}
