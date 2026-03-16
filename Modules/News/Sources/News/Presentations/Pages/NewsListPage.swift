//
//  NewsListPage.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import SwiftUI
import DesignSystemIOS
import DesignSystemCore
import Core

struct NewsListPage: View {
    @EnvironmentObject var theme: NewsTheme
    @StateObject private var viewModel: NewsListViewModel
    private let themeManager: any ThemeManagerProtocol
    private let onSelectArticle: (NewsArticle) -> Void

    init(
        viewModel: NewsListViewModel,
        themeManager: any ThemeManagerProtocol,
        onSelectArticle: @escaping (NewsArticle) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.themeManager = themeManager
        self.onSelectArticle = onSelectArticle
    }

    var body: some View {
        ZStack {
            theme.pageBackground.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 12) {
                    if viewModel.isLoading {
                        ForEach(1...10, id: \.self) { _ in
                            ShimmerView(height: 360, color: .gray, cornerRadius: 12)
                                .padding(.horizontal, 12)
                        }
                    } else if viewModel.articles.isEmpty {
                        Text("No Articles")
                    } else {
                        ForEach(viewModel.articles) { news in
                            NewsCard(article: news)
                                .onTapGesture {
                                    onSelectArticle(news)
                                }
                                .padding(.horizontal, 12)
                        }
                    }
                }
            }

            if let errorMessage = viewModel.errorMessage {
                VStack {
                    Spacer()

                    ToastView(message: errorMessage)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1)

                }
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.errorMessage)
        .navigationTitle("News App")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                themeMenu
            }
        }
        .onAppear {
            Task {
                await viewModel.load()
            }
        }
    }

    private var themeMenu: some View {
        Menu("Theme") {
            Button("System") {
                themeManager.useSystemTheme()
            }

            Button("Light") {
                themeManager.useLightTheme()
            }

            Button("Dark") {
                themeManager.useDarkTheme()
            }
        }
    }
}
