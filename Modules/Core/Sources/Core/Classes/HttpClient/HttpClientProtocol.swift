//
//  HttpClientProtocol.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 24/02/26.
//


import Foundation
import Combine

public protocol HttpClientProtocol: Sendable {
    func request<T: Codable>(
        url: String,
        method: HttpMethod,
        queryParams: [String: Any]?,
        body: [String: Any]?,
        formData: FormData?
    ) async throws -> BaseResponse<T>
}

// Provide Default Value
public extension HttpClientProtocol {
    func request<T: Codable>(
        _ path: String = "",
        url: String? = nil,
        method: HttpMethod = .get,
        queryParams: [String: Any]? = nil,
        body: [String: Any]? = nil,
        formData: FormData? = nil
    ) async throws -> BaseResponse<T> {
        let url = url ?? "http://127.0.0.1:8000" + path

        return try await request(
            url: url,
            method: method,
            queryParams: queryParams,
            body: body,
            formData: formData
        )
    }
}

// HTTP methods defined in RFC 7231 §4.3
public enum HttpMethod: String {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case query = "QUERY"
    case trace = "TRACE"
}


public struct FormData {
    public var name: String
    public var data: Data
    public var fileName: String
    public var mimeType: String
    
    public init(name: String, data: Data, fileName: String, mimeType: String) {
        self.name = name
        self.data = data
        self.fileName = fileName
        self.mimeType = mimeType
    }
}
