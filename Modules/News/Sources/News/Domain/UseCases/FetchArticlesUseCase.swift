//
//  FetchArticlesUseCase.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//


import Foundation
import Core

@MainActor
final class FetchArticlesUseCase {
    private let repository = NewsRepository()

    func execute() async throws -> [NewsArticle] {
        try await repository.fetchArticles()
    }
}

@MainActor
final class FetchArticleUseCase {
    private let repository = NewsRepository()

    func execute(id: String) async throws -> NewsArticle? {
        try await repository.fetchArticle(id: id)
    }
}
