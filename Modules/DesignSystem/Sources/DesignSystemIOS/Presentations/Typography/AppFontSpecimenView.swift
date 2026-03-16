//
//  AppFontSpecimenView.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 16/03/26.
//

import SwiftUI

public struct AppFontSpecimenView: View {
    @EnvironmentObject var theme: NewsTheme

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("App Typography")
                    .appFont(.detailTitle)
                    .foregroundStyle(theme.textPrimary)

                Text("Use this screen to verify font registration, hierarchy, and spacing.")
                    .appFont(.bodyMD)
                    .foregroundStyle(theme.textSecondary)

                ForEach(AppFontStyle.allCases, id: \.self) { style in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(label(for: style))
                            .appFont(.metaXS, weight: .semibold, family: .systemMonospaced)
                            .foregroundStyle(theme.textMuted)

                        Text(sampleText(for: style))
                            .appFont(style)
                            .foregroundStyle(theme.textPrimary)

                        Divider()
                            .background(theme.divider)
                    }
                }
            }
            .padding(20)
        }
        .background(theme.pageBackground)
    }

    private func label(for style: AppFontStyle) -> String {
        switch style {
        case .labelXS:
            "labelXS"
        case .metaXS:
            "metaXS"
        case .titleMD:
            "titleMD"
        case .bodyLG:
            "bodyLG"
        case .bodyMD:
            "bodyMD"
        case .bodySM:
            "bodySM"
        case .detailTitle:
            "detailTitle"
        case .detailLead:
            "detailLead"
        case .toast:
            "toast"
        }
    }

    private func sampleText(for style: AppFontStyle) -> String {
        switch style {
        case .labelXS:
            "BREAKING · WORLD"
        case .metaXS:
            "Elena Vasquez · 2h ago · 4 min read"
        case .titleMD:
            "Global Leaders Convene for Emergency Climate Summit"
        case .bodyLG:
            "A broader body style for summaries, promo cards, and prominent supporting copy."
        case .bodyMD:
            "Standard reading text for article content and descriptive UI copy."
        case .bodySM:
            "Compact supporting text for toolbars, labels, and metadata."
        case .detailTitle:
            "Flight disruptions continue after airport fire"
        case .detailLead:
            "Lead paragraph styling should feel prominent without overpowering the headline."
        case .toast:
            "Unable to load the article right now."
        }
    }
}

#Preview {
    AppFontSpecimenView()
        .environmentObject(NewsTheme())
}
