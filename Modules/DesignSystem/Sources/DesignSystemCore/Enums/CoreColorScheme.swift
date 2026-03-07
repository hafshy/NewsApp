//
//  CoreColorScheme.swift
//  DesignSystem
//
//  Created by Hafshy Yazid Albisthami on 26/02/26.
//

import Foundation
import SwiftUI

public enum CoreColorScheme: String, CaseIterable, Codable, Sendable {
    case system
    case light
    case dark
    
    public var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
