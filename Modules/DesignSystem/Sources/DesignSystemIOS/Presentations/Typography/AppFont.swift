//
//  AppFont.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 16/03/26.
//

import CoreText
import DesignSystemCore
import SwiftUI
import UIKit

public enum AppFontFamily: Sendable {
    case systemSans
    case systemSerif
    case systemMonospaced
    case montserrat
}

public enum AppFontStyle: CaseIterable, Sendable {
    case labelXS
    case metaXS
    case titleMD
    case bodyLG
    case bodyMD
    case bodySM
    case detailTitle
    case detailLead
    case toast

    var size: CGFloat {
        switch self {
        case .labelXS:
            9
        case .metaXS:
            11
        case .titleMD:
            20
        case .bodyLG:
            18
        case .bodyMD:
            15
        case .bodySM:
            13
        case .detailTitle:
            24
        case .detailLead:
            16
        case .toast:
            13
        }
    }

    var weight: Font.Weight {
        switch self {
        case .labelXS:
            .bold
        case .metaXS:
            .regular
        case .titleMD:
            .bold
        case .bodyLG:
            .regular
        case .bodyMD:
            .regular
        case .bodySM:
            .medium
        case .detailTitle:
            .bold
        case .detailLead:
            .medium
        case .toast:
            .medium
        }
    }

    var family: AppFontFamily {
        switch self {
        case .labelXS, .metaXS:
            .montserrat
        case .titleMD, .detailTitle, .detailLead:
            .systemSerif
        case .bodyLG, .bodyMD, .bodySM, .toast:
            .montserrat
        }
    }
}

enum AppFontProvider {
    private static let didRegisterMontserrat = registerMontserratFont()

    static func font(
        style: AppFontStyle,
        weight: Font.Weight? = nil,
        family: AppFontFamily? = nil
    ) -> Font {
        let resolvedWeight = weight ?? style.weight
        let resolvedFamily = family ?? style.family

        switch resolvedFamily {
        case .systemSans:
            return .system(size: style.size, weight: resolvedWeight)
        case .systemSerif:
            return .system(size: style.size, weight: resolvedWeight, design: .serif)
        case .systemMonospaced:
            return .system(size: style.size, weight: resolvedWeight, design: .monospaced)
        case .montserrat:
            _ = didRegisterMontserrat
            if let fontName = montserratFontName(for: resolvedWeight),
               UIFont(name: fontName, size: style.size) != nil {
                return .custom(fontName, size: style.size)
            }

            return .system(size: style.size, weight: resolvedWeight)
        }
    }

    private static func montserratFontName(for weight: Font.Weight) -> String? {
        switch weight {
        case .bold:
            "Montserrat-Bold"
        case .semibold:
            "Montserrat-SemiBold"
        case .medium:
            "Montserrat-Medium"
        default:
            "Montserrat-Regular"
        }
    }

    private static func registerMontserratFont() -> Bool {
        let bundle = DesignSystemCoreResources.bundle
        let candidates: [URL?] = [
            bundle.url(forResource: "Montserrat-Variable", withExtension: "ttf"),
            bundle.url(forResource: "Montserrat-Variable", withExtension: "ttf", subdirectory: "Fonts")
        ]

        guard let fontURL = candidates.compactMap({ $0 }).first else {
            return false
        }

        var error: Unmanaged<CFError>?
        let registered = CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error)

        if registered {
            return true
        }

        if let nsError = error?.takeRetainedValue() as Error?,
           (nsError as NSError).code == CTFontManagerError.alreadyRegistered.rawValue {
            return true
        }

        return false
    }
}
