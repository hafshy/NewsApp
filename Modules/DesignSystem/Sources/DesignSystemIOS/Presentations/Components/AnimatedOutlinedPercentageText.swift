//
//  AnimatedOutlinedPercentageText.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 16/03/26.
//

import SwiftUI

public struct AnimatedOutlinedPercentageText: View {
    private let targetValue: Int
    private let style: AppFontStyle
    private let weight: Font.Weight?
    private let family: AppFontFamily?
    private let fillColor: Color
    private let strokeColor: Color
    private let lineWidth: CGFloat
    private let stepDuration: Double
    private let startValue: Int

    @State private var displayedValue: Int
    @State private var animationTask: Task<Void, Never>?
    @State private var hasStartedAnimation = false

    public init(
        value: Int,
        style: AppFontStyle,
        weight: Font.Weight? = nil,
        family: AppFontFamily? = nil,
        fillColor: Color,
        strokeColor: Color,
        lineWidth: CGFloat = 2,
        stepDuration: Double = 0.001,
        startValue: Int = 1
    ) {
        self.targetValue = value
        self.style = style
        self.weight = weight
        self.family = family
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.stepDuration = stepDuration
        self.startValue = startValue
        _displayedValue = State(initialValue: max(0, startValue))
    }

    public var body: some View {
        OutlinedText(
            "\(displayedValue)%",
            style: style,
            weight: weight,
            family: family,
            fillColor: fillColor,
            strokeColor: strokeColor,
            lineWidth: lineWidth
        )
        .onAppear {
            guard !hasStartedAnimation else { return }
            hasStartedAnimation = true
            startAnimation()
        }
    }

    private func startAnimation() {
        animationTask?.cancel()

        let initialValue = min(max(0, startValue), max(0, targetValue))
        displayedValue = initialValue

        guard targetValue > initialValue else { return }

        animationTask = Task {
            for nextValue in (initialValue + 1)...targetValue {
                try? await Task.sleep(for: .seconds(stepDuration))
                guard !Task.isCancelled else { return }

                await MainActor.run {
                    displayedValue = nextValue
                }
            }
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [.blue, .cyan],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()

        AnimatedOutlinedPercentageText(
            value: 90,
            style: .detailTitle,
            weight: .bold,
            family: .systemSerif,
            fillColor: .white,
            strokeColor: .black,
            lineWidth: 3,
            stepDuration: 0.01
        )
    }
}
