//
//  BaseViewModelProtocol.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 11/07/25.
//


import SwiftUI
import Combine

// MARK: - Protocol
public protocol BaseViewModelProtocol: ObservableObject {
    var isLoading: Bool { get set }
    var error: String? { get set }
    var cancellables: Set<AnyCancellable> { get set }
}

public class BaseViewModel: BaseViewModelProtocol {
    @Published public var isLoading: Bool = false
    @Published public var error: String? = nil
    public var cancellables = Set<AnyCancellable>()

    public init() {
        onInit()
    }
    
    open func onInit() {
        
    }
}
