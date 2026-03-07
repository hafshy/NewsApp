//
//  NewsRepository.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import Foundation
import Core

@MainActor
public final class NewsRepository {

    private let service = NewsLocalService()

    func fetchArticles() async throws -> [NewsArticle] {
        let articles = try await service.fetchArticles()
        return articles
    }

    func fetchArticle(id: String) async throws -> NewsArticle? {
        let articles = try await service.fetchArticles()
        return articles.first { $0.id.uuidString == id.lowercased() }
    }
}
