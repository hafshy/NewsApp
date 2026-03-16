//
//  OutlinedText.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 16/03/26.
//

import SwiftUI

public struct OutlinedText: View {
    private let text: String
    private let style: AppFontStyle
    private let weight: Font.Weight?
    private let family: AppFontFamily?
    private let fillColor: Color
    private let strokeColor: Color
    private let lineWidth: CGFloat

    public init(
        _ text: String,
        style: AppFontStyle,
        weight: Font.Weight? = nil,
        family: AppFontFamily? = nil,
        fillColor: Color,
        strokeColor: Color,
        lineWidth: CGFloat = 2
    ) {
        self.text = text
        self.style = style
        self.weight = weight
        self.family = family
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
    }

    public var body: some View {
        ZStack {
            ForEach(outlineOffsets, id: \.self) { offset in
                baseText
                    .foregroundColor(strokeColor)
                    .offset(x: offset.width, y: offset.height)
            }

            baseText
                .foregroundColor(fillColor)
        }
    }

    private var baseText: some View {
        Text(text)
            .font(AppFontProvider.font(style: style, weight: weight, family: family))
    }

    private var outlineOffsets: [CGSize] {
        let radius = max(1, Int(ceil(lineWidth)))
        var offsets = Set<CGSize>()

        for x in -radius...radius {
            for y in -radius...radius where x != 0 || y != 0 {
                let distance = sqrt(Double((x * x) + (y * y)))
                if distance <= Double(lineWidth) + 0.5 {
                    offsets.insert(CGSize(width: x, height: y))
                }
            }
        }

        return offsets.sorted {
            if $0.width == $1.width {
                return $0.height < $1.height
            }
            return $0.width < $1.width
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [.orange, .red],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()

        OutlinedText(
            "Breaking",
            style: .detailTitle,
            weight: .bold,
            family: .systemSerif,
            fillColor: .white,
            strokeColor: .black,
            lineWidth: 3
        )
    }
}
