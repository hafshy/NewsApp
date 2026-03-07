//
//  CoreTheme.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 26/02/26.
//

import SwiftUI

public struct CoreTheme: Sendable {
    public let colors: CoreColors
}

public extension CoreTheme {
    static let `default` = CoreTheme(colors: .default)
}

public struct CoreColors: Sendable {
    public let primary: Primary
    public let grey: Grey
    public let background: Background
    public let semantic: Semantic
    
    public struct Primary: Sendable, Equatable {
        public let primary100: Color
        public let primary200: Color
        public let primary300: Color
        public let primary400: Color
        public let primary500: Color
        public let primary600: Color
        public let primary700: Color
        public let primary800: Color
        public let primary900: Color
    }
    public struct Grey: Sendable, Equatable {
        public let grey100: Color
        public let grey200: Color
        public let grey300: Color
        public let grey400: Color
        public let grey500: Color
        public let grey600: Color
        public let grey700: Color
        public let grey800: Color
        public let grey900: Color
    }
    public struct Background: Sendable, Equatable {
        public let primary: Color
        public let secondary: Color
        public let tertiary: Color
        public let elevated: Color
    }
    public struct Semantic: Sendable, Equatable {
        public let successBG: Color
        public let successFG: Color
        public let warningBG: Color
        public let warningFG: Color
        public let errorBG: Color
        public let errorFG: Color
    }
}

public extension CoreColors {
    static let `default` = CoreColors(
        primary: .init(
            primary100: Color("primary-100-color", bundle: .module),
            primary200: Color("primary-200-color", bundle: .module),
            primary300: Color("primary-300-color", bundle: .module),
            primary400: Color("primary-400-color", bundle: .module),
            primary500: Color("primary-500-color", bundle: .module),
            primary600: Color("primary-600-color", bundle: .module),
            primary700: Color("primary-700-color", bundle: .module),
            primary800: Color("primary-800-color", bundle: .module),
            primary900: Color("primary-900-color", bundle: .module)
        ),
        grey: .init(
            grey100: Color("grey-100-color", bundle: .module),
            grey200: Color("grey-200-color", bundle: .module),
            grey300: Color("grey-300-color", bundle: .module),
            grey400: Color("grey-400-color", bundle: .module),
            grey500: Color("grey-500-color", bundle: .module),
            grey600: Color("grey-600-color", bundle: .module),
            grey700: Color("grey-700-color", bundle: .module),
            grey800: Color("grey-800-color", bundle: .module),
            grey900: Color("grey-900-color", bundle: .module)
        ),
        background: .init(
            primary: Color("bg-primary-color", bundle: .module),
            secondary: Color("bg-secondary-color", bundle: .module),
            tertiary: Color("bg-tertiary-color", bundle: .module),
            elevated: Color("bg-elevated-color", bundle: .module)
        ),
        semantic: .init(
            successBG: Color("bg-success-color", bundle: .module),
            successFG: Color("fg-success-color", bundle: .module),
            warningBG: Color("bg-warning-color", bundle: .module),
            warningFG: Color("fg-warning-color", bundle: .module),
            errorBG: Color("bg-error-color", bundle: .module),
            errorFG: Color("fg-error-color", bundle: .module)
        )
    )
}

