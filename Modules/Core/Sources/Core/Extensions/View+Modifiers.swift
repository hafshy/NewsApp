//
//  View+Modifiers.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import SwiftUI
import Combine


// MARK: .erased
public extension View {
    var erased: AnyView {
        return AnyView(self)
    }
}

// MARK: .if
public extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}


// MARK: .onChange
public extension View {
    @ViewBuilder func onChange<T: Equatable>(_ value: T, onChange: @escaping () -> Void) -> some View {
        if #available(iOS 14.0, *) {
            self.onChange(of: value) { _ in
                onChange()
            }
        } else {
            self.onReceive(Just(value)) { (value) in
                onChange()
            }
        }
    }
}


public extension View {
    func apply<V: View>(@ViewBuilder _ block: (Self) -> V) -> V { block(self) }
}

public extension View {
    func disableDynamicType() -> some View {
        self.apply {
            if #available(iOS 17, *) {
                $0.dynamicTypeSize(.medium)
            }
        }
        .minimumScaleFactor(0.5)
    }
}

