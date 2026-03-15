//
//  NewsApp.swift
//  NewsApp
//
//  Created by Hafshy Yazid Albisthami on 06/03/26.
//

import SwiftUI
import DesignSystemCore
import DesignSystemIOS
import Core
import Combine

@main
struct NewsApp: App {
    @StateObject private var container: AppContainer

    @MainActor
    init() {
        _container = StateObject(wrappedValue: AppContainer())
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(container: container)
        }
    }
}
