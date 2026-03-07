//
//  Navigating.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

public protocol Navigating: AnyObject {
    func push(_ route: any Routable)
    func pop()
    func popToRoot()
    func present(sheet route: any Routable)
    func dismiss()
}

public protocol Routable: Hashable, Identifiable {}
