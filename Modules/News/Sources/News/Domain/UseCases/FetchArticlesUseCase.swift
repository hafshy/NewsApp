//
//  FetchArticlesUseCase.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//


import Foundation
import Core

public protocol FetchArticlesUseCaseProtocol {
    @MainActor
    func execute() async throws -> [NewsArticle]
}

final class FetchArticlesUseCase: FetchArticlesUseCaseProtocol {
    private let repository: any NewsRepositoryProtocol

    init(repository: any NewsRepositoryProtocol) {
        self.repository = repository
    }

    @MainActor
    func execute() async throws -> [NewsArticle] {
        try await repository.fetchArticles()
    }
}

final class FetchArticleUseCase {
    private let repository: any NewsRepositoryProtocol

    init(repository: any NewsRepositoryProtocol) {
        self.repository = repository
    }

    @MainActor
    func execute(id: String) async throws -> NewsArticle? {
        try await repository.fetchArticle(id: id)
    }
}
