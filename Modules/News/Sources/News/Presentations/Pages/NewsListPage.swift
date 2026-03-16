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
    private struct CategoryItem: Identifiable {
        let id: String
        let title: String
        let iconName: String
    }

    private struct SidebarMenuItem: Identifiable {
        let id: String
        let title: String
        let iconName: String
        let showsChevron: Bool
    }

    private enum Layout {
        static let headerBlue = Color(hex: "#32B7EF")
        static let pageSpacing: CGFloat = 14
        static let horizontalPadding: CGFloat = 12
        static let sidebarWidth: CGFloat = 310
    }

    private let categories: [CategoryItem] = [
        .init(id: "breaking", title: "Breaking", iconName: "ic_breaking"),
        .init(id: "video", title: "Video", iconName: "ic_video"),
        .init(id: "ai-news", title: "A.I. News", iconName: "ic_ai"),
        .init(id: "entertainment", title: "Entertainment", iconName: "ic_entertainment"),
        .init(id: "sports", title: "Sports", iconName: "ic_sport"),
        .init(id: "business", title: "Business", iconName: "ic_conservative"),
        .init(id: "liberal", title: "Liberal", iconName: "ic_liberal"),
        .init(id: "technology", title: "Technology", iconName: "ic_technology"),
        .init(id: "business", title: "Business", iconName: "ic_business"),
        .init(id: "health", title: "Health", iconName: "ic_health"),
        .init(id: "travel", title: "Travel", iconName: "ic_travel"),
        .init(id: "lifestyle", title: "Lifestyle", iconName: "ic_lifestyle"),
        .init(id: "happiness", title: "Happiness", iconName: "ic_happiness"),
        .init(id: "sustainability", title: "Sustainability", iconName: "ic_sustainability")
    ]

    private let sidebarItems: [SidebarMenuItem] = [
        .init(id: "saved", title: "Saved Stories", iconName: "star.fill", showsChevron: false),
        .init(id: "rate-news", title: "How We Rate News", iconName: "shield.fill", showsChevron: false),
        .init(id: "faq", title: "FAQ", iconName: "questionmark.bubble.fill", showsChevron: false),
        .init(id: "rate-app", title: "Rate This App", iconName: "rectangle.and.pencil.and.ellipsis", showsChevron: false),
        .init(id: "settings", title: "Settings", iconName: "gearshape.fill", showsChevron: false),
        .init(id: "contact", title: "Contact Us", iconName: "questionmark.circle.fill", showsChevron: false),
        .init(id: "language", title: "Choose Language", iconName: "globe", showsChevron: true),
        .init(id: "location", title: "Choose Location", iconName: "location.viewfinder", showsChevron: true)
    ]

    @EnvironmentObject var theme: NewsTheme
    @StateObject private var viewModel: NewsListViewModel
    @State private var selectedCategoryID = "breaking"
    @State private var isSidebarPresented = false
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
            
            VStack(spacing: 8) {
                headerSection
                
                categorySection

                ScrollView {
                    VStack(spacing: 0) {
                        LazyVStack(spacing: 12) {
                            if viewModel.isLoading {
                                ForEach(1...10, id: \.self) { _ in
                                    ShimmerView(height: 360, color: .gray, cornerRadius: 12)
                                        .padding(.horizontal, Layout.horizontalPadding)
                                }
                            } else if viewModel.articles.isEmpty {
                                Text("No Articles")
                                    .appFont(.bodyMD)
                                    .foregroundStyle(theme.textSecondary)
                                    .padding(.top, 24)
                            } else {
                                ForEach(viewModel.articles) { news in
                                    NewsCard(article: news)
                                        .onTapGesture {
                                            onSelectArticle(news)
                                        }
                                        .padding(.horizontal, Layout.horizontalPadding)
                                }
                            }
                        }
                        .padding(.bottom, 24)
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

            if isSidebarPresented {
                sidebarOverlay
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.errorMessage)
        .animation(.spring(response: 0.32, dampingFraction: 0.86), value: isSidebarPresented)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            Task {
                await viewModel.load()
            }
        }
    }

    private var headerSection: some View {
        VStack(spacing: 8) {
            topBar
            searchRow
        }
        .padding(.horizontal, Layout.horizontalPadding)
        .padding(.bottom, 8)
        .background(Layout.headerBlue.ignoresSafeArea(.all))
    }

    private var topBar: some View {
        ZStack(alignment: .center) {
            HStack {
                HStack(spacing: 20) {
                    Button {
                        isSidebarPresented = true
                    } label: {
                        AppImage.system("line.3.horizontal", tint: .white)
                            .frame(width: 20, height: 20)
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                    } label: {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .stroke(theme.errorForeground, lineWidth: 1.25)
                            .frame(width: 24, height: 24)
                            .overlay {
                                Text("P")
                                    .appFont(.metaXS, weight: .medium, family: .montserrat)
                                    .foregroundStyle(theme.errorForeground)
                            }
                    }
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    Menu {
                        Button("System") {
                            themeManager.useSystemTheme()
                        }

                        Button("Light") {
                            themeManager.useLightTheme()
                        }

                        Button("Dark") {
                            themeManager.useDarkTheme()
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text("Global")
                                .appFont(.bodySM, weight: .semibold, family: .montserrat)
                            AppImage.system("chevron.down", tint: .white)
                                .frame(width: 10, height: 10)
                        }
                        .foregroundStyle(.white)
                    }

                    AppImage.system("person.crop.circle.fill", tint: .white)
                        .frame(width: 22, height: 22)
                }
            }
            
            HStack {
                Spacer()
                
                VStack(spacing: 0) {
                    Text("Oigetit")
                        .appFont(.titleMD, weight: .semibold, family: .montserrat)
                        .foregroundStyle(.white)

                    Text("Fake News Filter")
                        .appFont(.labelXS, weight: .medium, family: .montserrat)
                        .foregroundStyle(Color.white.opacity(0.9))
                }

                Spacer()
            }
        }
    }

    private var searchRow: some View {
        HStack(spacing: 10) {
            HStack(spacing: 8) {
                AppImage.asset("ic_search", tint: theme.errorForeground)
                    .frame(width: 16, height: 16)

                Text("What News are you looking for?")
                    .appFont(.bodySM, weight: .regular, family: .montserrat)
                    .foregroundStyle(Color.gray.opacity(0.8))

                Spacer(minLength: 0)
            }
            .padding(8)
            .background(Color.white.opacity(0.95))
            .clipShape(Capsule())

            AppImage.asset("ic_video", tint: .white)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 30, height: 30)
                .clipped()
        }
    }

    private var categorySection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories) { category in
                    Button {
                        selectedCategoryID = category.id
                    } label: {
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(category.id == selectedCategoryID ? Layout.headerBlue : Color(token: theme.core.colors.grey.grey100))
                            .frame(width: 64, height: 60)
                            .overlay {
                                VStack(alignment: .center, spacing: 4) {
                                    AppImage.asset(
                                        category.iconName,
                                        tint: Color.gray.opacity(0.65)
                                    )
                                    .frame(width: 32, height: 32)
                                    
                                    Text(category.title)
                                        .appFont(.labelXS, weight: .semibold, family: .montserrat)
                                        .foregroundStyle(theme.textPrimary)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 60)
                                        .lineLimit(1)
                                }
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, Layout.horizontalPadding)
        }
    }

    private var sidebarOverlay: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Color.black.opacity(0.18)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isSidebarPresented = false
                    }

                sidebarPanel(height: geometry.size.height)
                    .transition(.move(edge: .leading))
            }
        }
        .zIndex(2)
    }

    private func sidebarPanel(height: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(spacing: 0) {
                        ForEach(sidebarItems) { item in
                            sidebarRow(item)
                        }
                    }

                    VStack(alignment: .leading, spacing: 18) {
                        Text("Version: 1.1.19(1)")
                            .appFont(.bodySM, family: .montserrat)
                            .foregroundStyle(Color.gray.opacity(0.7))

                        Text("Delete Account")
                            .appFont(.bodyMD, family: .montserrat)
                            .foregroundStyle(theme.textPrimary)
                    }
                    .padding(.horizontal, 22)
                    .padding(.vertical, 24)

                    Divider()

                    VStack(alignment: .leading, spacing: 18) {
                        Text("CATEGORIES")
                            .appFont(.bodySM, weight: .medium, family: .montserrat)
                            .foregroundStyle(Color.gray.opacity(0.7))

                        ForEach(categories) { category in
                            Button {
                                selectedCategoryID = category.id
                                isSidebarPresented = false
                            } label: {
                                Text(category.title)
                                    .appFont(.bodyMD, weight: category.id == selectedCategoryID ? .semibold : .regular, family: .montserrat)
                                    .foregroundStyle(theme.textPrimary)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 22)
                    .padding(.vertical, 24)
                }
                .padding(.bottom, 24)
            }
        }
        .frame(width: Layout.sidebarWidth, height: height, alignment: .topLeading)
        .background(Color.white)
        .shadow(color: .black.opacity(0.18), radius: 24, x: 6, y: 0)
    }

    private func sidebarRow(_ item: SidebarMenuItem) -> some View {
        VStack(spacing: 0) {
            Button {
            } label: {
                HStack(spacing: 16) {
                    AppImage.system(item.iconName, tint: theme.textPrimary)
                        .frame(width: 20, height: 20)

                    Text(item.title)
                        .appFont(.bodyMD, family: .montserrat)
                        .foregroundStyle(theme.textPrimary)

                    Spacer()

                    if item.showsChevron {
                        AppImage.system("chevron.down", tint: theme.textPrimary)
                            .frame(width: 12, height: 12)
                    }
                }
                .padding(.horizontal, 22)
                .frame(height: 52)
            }
            .buttonStyle(.plain)

            if item.id == "contact" || item.id == "location" {
                Divider()
            }
        }
    }
}
