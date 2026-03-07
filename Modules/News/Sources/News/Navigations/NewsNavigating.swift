//
//  NewsNavigating.swift
//  News
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//


import Core

public protocol NewsNavigating: AnyObject {
    func push(_ route: NewsRoute)
    func pop()
    func popToRoot()
    func present(sheet route: NewsRoute)
    func dismiss()
}