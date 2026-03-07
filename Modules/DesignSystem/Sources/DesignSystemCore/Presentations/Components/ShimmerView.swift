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

/// A view modifier that applies an animated "shimmer" to any view, typically to show that an operation is in progress.
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
        // Calculate unit point dimensions beyond the gradient's edges by the band size
        self.min = 0 - bandSize
        self.max = 1 + bandSize
    }

    /// The default animation effect.
    public static let defaultAnimation = Animation.linear(duration: 1).delay(0.25).repeatForever(autoreverses: false)

    /// The start unit point of our gradient, adjusting for layout direction.
    var startPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: max, y: min) : UnitPoint(x: 0, y: 1)
        } else {
            return isInitialState ? UnitPoint(x: min, y: min) : UnitPoint(x: 1, y: 1)
        }
    }

    /// The end unit point of our gradient, adjusting for layout direction.
    var endPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: 1, y: 0) : UnitPoint(x: min, y: max)
        } else {
            return isInitialState ? UnitPoint(x: 0, y: 0) : UnitPoint(x: max, y: max)
        }
    }

    @Environment(\.colorScheme) private var colorScheme

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
                // Delay the animation until the initial layout is established
                // to prevent animating the appearance of the view
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    isInitialState = false
                }
            }
    }
}

public extension View {
    /// Adds an animated shimmering effect to any view, typically to show that an operation is in progress.
    /// - Parameters:
    ///   - active: Convenience parameter to conditionally enable the effect. Defaults to `true`.
    ///   - animation: A custom animation. Defaults to ``Shimmer/defaultAnimation``.
    ///   - gradient: A custom gradient. Defaults to ``Shimmer/defaultGradient``.
    ///   - bandSize: The size of the animated mask's "band". Defaults to 0.3 unit points, which corresponds to
    /// 20% of the extent of the gradient.
    @ViewBuilder func shimmering(
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
