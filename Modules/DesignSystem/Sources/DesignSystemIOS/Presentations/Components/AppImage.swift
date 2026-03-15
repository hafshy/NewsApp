//
//  AppImage.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 15/03/26.
//

import Foundation
import SDWebImageSwiftUI
import SwiftUI

public struct AppImage: View {
    public enum Source: Equatable, Sendable {
        case asset(name: String)
        case system(name: String)
        case remote(url: URL?)
    }

    private let source: Source
    private let contentMode: ContentMode
    private let placeholderSystemName: String
    private let tint: Color?

    public init(
        source: Source,
        contentMode: ContentMode = .fill,
        placeholderSystemName: String = "photo",
        tint: Color? = nil
    ) {
        self.source = source
        self.contentMode = contentMode
        self.placeholderSystemName = placeholderSystemName
        self.tint = tint
    }

    public static func asset(
        _ name: String,
        contentMode: ContentMode = .fill,
        placeholderSystemName: String = "photo",
        tint: Color? = nil
    ) -> AppImage {
        AppImage(
            source: .asset(name: name),
            contentMode: contentMode,
            placeholderSystemName: placeholderSystemName,
            tint: tint
        )
    }

    public static func system(
        _ name: String,
        contentMode: ContentMode = .fit,
        tint: Color? = nil
    ) -> AppImage {
        AppImage(
            source: .system(name: name),
            contentMode: contentMode,
            placeholderSystemName: name,
            tint: tint
        )
    }

    public static func remote(
        _ url: URL?,
        contentMode: ContentMode = .fill,
        placeholderSystemName: String = "photo",
        tint: Color? = nil
    ) -> AppImage {
        AppImage(
            source: .remote(url: url),
            contentMode: contentMode,
            placeholderSystemName: placeholderSystemName,
            tint: tint
        )
    }

    public var body: some View {
        content
    }

    @ViewBuilder
    private var content: some View {
        switch source {
        case .asset(let name):
            baseImage(Image(name))
        case .system(let name):
            baseImage(Image(systemName: name))
        case .remote(let url):
            WebImage(url: url)
                .resizable()
                .placeholder {
                    placeholder
                }
                .aspectRatio(contentMode: contentMode)
        }
    }

    private func baseImage(_ image: Image) -> some View {
        image
            .renderingMode(tint == nil ? .original : .template)
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .foregroundStyle(tint ?? .primary)
    }

    private var placeholder: some View {
        ZStack {
            Color.secondary.opacity(0.12)

            Image(systemName: placeholderSystemName)
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(tint ?? .secondary)
        }
    }
}
