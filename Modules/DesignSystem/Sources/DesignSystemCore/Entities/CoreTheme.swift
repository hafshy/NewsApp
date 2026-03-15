//
//  CoreTheme.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 26/02/26.
//

public struct ColorToken: Sendable, Hashable {
    public let assetName: String
    public let fallbackHex: String?

    public init(assetName: String, fallbackHex: String? = nil) {
        self.assetName = assetName
        self.fallbackHex = fallbackHex
    }
}

public struct CoreTheme: Sendable {
    public let colors: CoreColors

    public init(colors: CoreColors) {
        self.colors = colors
    }
}

public extension CoreTheme {
    static let `default` = CoreTheme(colors: .default)
}

public struct CoreColors: Sendable {
    public let primary: Primary
    public let grey: Grey
    public let background: Background
    public let semantic: Semantic

    public init(
        primary: Primary,
        grey: Grey,
        background: Background,
        semantic: Semantic
    ) {
        self.primary = primary
        self.grey = grey
        self.background = background
        self.semantic = semantic
    }

    public struct Primary: Sendable, Equatable {
        public let primary100: ColorToken
        public let primary200: ColorToken
        public let primary300: ColorToken
        public let primary400: ColorToken
        public let primary500: ColorToken
        public let primary600: ColorToken
        public let primary700: ColorToken
        public let primary800: ColorToken
        public let primary900: ColorToken
    }

    public struct Grey: Sendable, Equatable {
        public let grey100: ColorToken
        public let grey200: ColorToken
        public let grey300: ColorToken
        public let grey400: ColorToken
        public let grey500: ColorToken
        public let grey600: ColorToken
        public let grey700: ColorToken
        public let grey800: ColorToken
        public let grey900: ColorToken
    }

    public struct Background: Sendable, Equatable {
        public let primary: ColorToken
        public let secondary: ColorToken
        public let tertiary: ColorToken
        public let elevated: ColorToken
    }

    public struct Semantic: Sendable, Equatable {
        public let successBG: ColorToken
        public let successFG: ColorToken
        public let warningBG: ColorToken
        public let warningFG: ColorToken
        public let errorBG: ColorToken
        public let errorFG: ColorToken
    }
}

public extension CoreColors {
    static let `default` = CoreColors(
        primary: .init(
            primary100: ColorToken(assetName: "primary-100-color"),
            primary200: ColorToken(assetName: "primary-200-color"),
            primary300: ColorToken(assetName: "primary-300-color"),
            primary400: ColorToken(assetName: "primary-400-color"),
            primary500: ColorToken(assetName: "primary-500-color"),
            primary600: ColorToken(assetName: "primary-600-color"),
            primary700: ColorToken(assetName: "primary-700-color"),
            primary800: ColorToken(assetName: "primary-800-color"),
            primary900: ColorToken(assetName: "primary-900-color")
        ),
        grey: .init(
            grey100: ColorToken(assetName: "grey-100-color"),
            grey200: ColorToken(assetName: "grey-200-color"),
            grey300: ColorToken(assetName: "grey-300-color"),
            grey400: ColorToken(assetName: "grey-400-color"),
            grey500: ColorToken(assetName: "grey-500-color"),
            grey600: ColorToken(assetName: "grey-600-color"),
            grey700: ColorToken(assetName: "grey-700-color"),
            grey800: ColorToken(assetName: "grey-800-color"),
            grey900: ColorToken(assetName: "grey-900-color")
        ),
        background: .init(
            primary: ColorToken(assetName: "bg-primary-color"),
            secondary: ColorToken(assetName: "bg-secondary-color"),
            tertiary: ColorToken(assetName: "bg-tertiary-color"),
            elevated: ColorToken(assetName: "bg-elevated-color")
        ),
        semantic: .init(
            successBG: ColorToken(assetName: "bg-success-color"),
            successFG: ColorToken(assetName: "fg-success-color"),
            warningBG: ColorToken(assetName: "bg-warning-color"),
            warningFG: ColorToken(assetName: "fg-warning-color"),
            errorBG: ColorToken(assetName: "bg-error-color"),
            errorFG: ColorToken(assetName: "fg-error-color")
        )
    )
}
