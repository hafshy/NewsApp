//
//  NewsLocalService.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import Foundation
import Core

@MainActor
final class NewsLocalService {

    func fetchArticles() async throws -> [NewsArticle] {
        try await Task.sleep(nanoseconds: 4_000_000_000)
        return try load()
    }

    private func load() throws -> [NewsArticle] {
        guard let url = Bundle.module.url(forResource: "news_articles", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        let data = try Data(contentsOf: url)
//        return try JSONDecoder().decode([NewsArticle].self, from: data)
        return NewsArticle.samples
    }
}
