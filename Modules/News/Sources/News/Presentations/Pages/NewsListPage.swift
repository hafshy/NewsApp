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

public struct NewsListPage: View {
    @EnvironmentObject var theme: NewsTheme
    @StateObject var viewModel = NewsListViewModel()
    var coordinator: NewsCoordinator
    
    public init(coordinator: NewsCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
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
                                .padding(.horizontal, 12)
                                .onTapGesture {
                                    if news.isError {
                                        viewModel.showError("Failed to load article")
                                    } else {
                                        coordinator.push(.detail(article: news))
                                    }
                                }
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
        .onAppear {
            Task {
                await viewModel.load()
            }
        }
    }
}
