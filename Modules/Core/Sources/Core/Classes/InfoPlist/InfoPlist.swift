//
//  InfoPlist.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 11/07/25.
//


import Foundation

public class InfoPlist {
    // Get value from "Info.plist" file
    public static func get<T>(_ key: String) -> T? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? T
    }
}
