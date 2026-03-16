//
//  Double+Percentage.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 16/03/26.
//

import Foundation

public extension Double {
    var percentageInt: Int {
        Int((self * 100).rounded())
    }
}
