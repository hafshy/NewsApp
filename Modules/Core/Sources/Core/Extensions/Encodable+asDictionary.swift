//
//  Encodable+asDictionary.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 24/02/26.
//

import Foundation

public extension Encodable {
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments
              ) as? [String: Any]
        else { return nil }

        return dictionary
    }
}
