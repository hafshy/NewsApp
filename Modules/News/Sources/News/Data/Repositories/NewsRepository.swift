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
    private let remoteService: any NewsRemoteServiceProtocol
    private let service: any NewsLocalServiceProtocol

    init(
        remoteService: any NewsRemoteServiceProtocol,
        service: any NewsLocalServiceProtocol
    ) {
        self.remoteService = remoteService
        self.service = service
    }

    @MainActor
    func fetchArticles() async throws -> [NewsArticle] {
        do {
            let articles = try await remoteService.fetchArticles()
            if !articles.isEmpty {
                return articles
            }
        } catch {
            Logger.warning("Falling back to local news payload: \(error.localizedDescription)")
        }

        return try await service.fetchArticles()
    }

    @MainActor
    func fetchArticle(id: String) async throws -> NewsArticle? {
        let articles = try await fetchArticles()
        return articles.first { String($0.id) == id }
    }
}
