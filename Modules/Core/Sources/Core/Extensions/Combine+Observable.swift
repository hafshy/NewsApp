//
//  AnyObserver.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 24/02/26.
//


import Foundation
import Combine

public typealias Observable<T> = AnyPublisher<T, Error>

public extension Observable {
    func subscribe(onNext:  ((Self.Output) -> Void)? = nil, onError: ((Self.Failure) -> Void)? = nil, onCompleted: (() -> Void)? = nil) -> AnyCancellable {
        return self.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                onCompleted?()
            case .failure(let failure):
                onError?(failure)
                onCompleted?()
            }
        }, receiveValue: { output in
            onNext?(output)
        })
    }
}

public struct AnyObserver<Output, Failure: Error> {
    let onNext: ((Output) -> Void)
    let onError: ((Failure) -> Void)
    let onCompleted: (() -> Void)
}

public struct Disposable {
    public var dispose: (() -> Void)?

    public init(dispose: (() -> Void)? = nil) {
        self.dispose = dispose
    }
}

public extension AnyPublisher {
    static func create(subscribe: @escaping (AnyObserver<Output, Failure>) -> Disposable) -> Self {
        let subject = PassthroughSubject<Output, Failure>()
        var disposable: Disposable?
        return subject
            .handleEvents(
                receiveSubscription: { subscription in
                    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.01) {
                        disposable = subscribe(AnyObserver(
                            onNext: { output in subject.send(output) },
                            onError: { failure in subject.send(completion: .failure(failure)) },
                            onCompleted: { subject.send(completion: .finished) }
                        ))
                    }
                },
                receiveCancel: { disposable?.dispose?() }
            )
            .eraseToAnyPublisher()
    }

    static func complete(_ result: Output) -> Self {
        self.create { observer in
            observer.onNext(result)
            observer.onCompleted()

            return Disposable()
        }
    }
}

public protocol ObservableObjectDelegate: AnyObject {
    var objectWillChange: ObservableObjectPublisher { get }
}
