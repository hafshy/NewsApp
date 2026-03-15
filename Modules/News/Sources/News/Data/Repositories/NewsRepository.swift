//
//  NewsRepository.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import Foundation
import Core

protocol NewsRepositoryProtocol {
    @MainActor
    func fetchArticles() async throws -> [NewsArticle]
    @MainActor
    func fetchArticle(id: String) async throws -> NewsArticle?
}

final class NewsRepository: NewsRepositoryProtocol {
    private let service: any NewsLocalServiceProtocol

    init(service: any NewsLocalServiceProtocol) {
        self.service = service
    }

    @MainActor
    func fetchArticles() async throws -> [NewsArticle] {
        try await service.fetchArticles()
    }

    @MainActor
    func fetchArticle(id: String) async throws -> NewsArticle? {
        let articles = try await service.fetchArticles()
        return articles.first { $0.id.uuidString == id.lowercased() }
    }
}
