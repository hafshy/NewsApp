//
//  ShimmerView.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import SwiftUI
import Core

public struct ShimmerView: View {
    var width: Double?
    var height: Double?
    var color: Color?
    var cornerRadius: Double

    public init(
        width: Double? = nil,
        height: Double? = nil,
        color: Color? = nil,
        cornerRadius: Double = 4
    ) {
        self.width = width
        self.height = height
        self.color = color
        self.cornerRadius = cornerRadius
    }

    public var body: some View {
        color
            .if(width != nil) { view in
                view.frame(width: width!)
            }
            .if(height != nil) { view in
                view.frame(height: height!)
            }
            .cornerRadius(cornerRadius)
            .shimmering()
    }
}

public struct Shimmer: ViewModifier {
    private let animation: Animation
    private let gradient: Gradient?
    private let min, max: CGFloat
    @State private var isInitialState = true
    @Environment(\.layoutDirection) private var layoutDirection

    public init(
        animation: Animation = Self.defaultAnimation,
        gradient: Gradient? = nil,
        bandSize: CGFloat = 0.3
    ) {
        self.animation = animation
        self.gradient = gradient
        self.min = 0 - bandSize
        self.max = 1 + bandSize
    }

    public static let defaultAnimation = Animation.linear(duration: 1)
        .delay(0.25)
        .repeatForever(autoreverses: false)

    var startPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: max, y: min) : UnitPoint(x: 0, y: 1)
        } else {
            return isInitialState ? UnitPoint(x: min, y: min) : UnitPoint(x: 1, y: 1)
        }
    }

    var endPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: 1, y: 0) : UnitPoint(x: min, y: max)
        } else {
            return isInitialState ? UnitPoint(x: 0, y: 0) : UnitPoint(x: max, y: max)
        }
    }

    public func body(content: Content) -> some View {
        let defaultGradient = Gradient(colors: [
            .black.opacity(0.15),
            .black.opacity(0.05),
            .black.opacity(0.15)
        ])

        content
            .mask(LinearGradient(gradient: gradient ?? defaultGradient, startPoint: startPoint, endPoint: endPoint))
            .animation(animation, value: isInitialState)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    isInitialState = false
                }
            }
    }
}

public extension View {
    @ViewBuilder
    func shimmering(
        active: Bool = true,
        animation: Animation = Shimmer.defaultAnimation,
        gradient: Gradient? = nil,
        bandSize: CGFloat = 0.3
    ) -> some View {
        if active {
            modifier(Shimmer(animation: animation, gradient: gradient, bandSize: bandSize))
        } else {
            self
        }
    }
}
