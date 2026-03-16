//
//  NewsRemoteService.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 16/03/26.
//

import Core
import Foundation

protocol NewsRemoteServiceProtocol {
    @MainActor
    func fetchArticles() async throws -> [NewsArticle]
}

final class NewsRemoteService: BaseService, NewsRemoteServiceProtocol {
    private static let breakingNewsURL = "https://api.oigetit.com/V3/GetBreakingNews"

    @MainActor
    func fetchArticles() async throws -> [NewsArticle] {
        let response: BaseResponse<[NewsArticle]> = try await request(
            url: Self.breakingNewsURL,
            method: .get,
            queryParams: [
                "category": 0,
                "filter": "all",
                "language": "EN",
                "region": ""
            ]
        )

        return response.data ?? []
    }
}
