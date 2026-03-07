//
//  NewsRoute.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import Core
import Foundation

public enum NewsRoute: Routable {
    case list
    case detail(article: NewsArticle)
    
    public var id: String {
        switch self {
        case .list:
            return "list"
        case .detail(let article):
            return "detail-\(article.id)"
        }
    }
}
