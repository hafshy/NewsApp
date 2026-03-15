//
//  NewsListViewModel.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import Foundation
import Core

@MainActor
public final class NewsListViewModel: ObservableObject {
    
    @Published var articles: [NewsArticle] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let fetchArticles: any FetchArticlesUseCaseProtocol
    private var dismissTask: Task<Void, Never>?

    public init(fetchArticles: any FetchArticlesUseCaseProtocol) {
        self.fetchArticles = fetchArticles
    }
    
    func load() async {
        guard articles.isEmpty else { return }
        isLoading = true
        errorMessage = nil
        do {
            articles = try await fetchArticles.execute()
        } catch {
            showError(error.localizedDescription)
        }
        isLoading = false
    }
    
    func showError(_ message: String) {
        dismissTask?.cancel()
        
        errorMessage = message
        
        dismissTask = Task {
            try? await Task.sleep(nanoseconds: 4_000_000_000) // 4 seconds
            guard !Task.isCancelled else { return }
            errorMessage = nil
        }
    }
}
