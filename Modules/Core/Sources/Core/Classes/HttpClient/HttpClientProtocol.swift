//
//  HttpClientProtocol.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 24/02/26.
//


import Foundation

public protocol HttpClientProtocol: Sendable {
    func request<T: Codable>(
        url: String,
        method: HttpMethod,
        headers: [String: String]?,
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
        headers: [String: String]? = nil,
        queryParams: [String: Any]? = nil,
        body: [String: Any]? = nil,
        formData: FormData? = nil
    ) async throws -> BaseResponse<T> {
        let url = url ?? "http://127.0.0.1:8000" + path

        return try await request(
            url: url,
            method: method,
            headers: headers,
            queryParams: queryParams,
            body: body,
            formData: formData
        )
    }
}

// HTTP methods defined in RFC 7231 §4.3
public enum HttpMethod: String, Sendable {
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


public struct FormData: Sendable {
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

public enum HttpClientError: Error, LocalizedError, Sendable {
    case invalidURL(String)
    case invalidResponse
    case unacceptableStatusCode(Int, Data?)
    case mockResponseNotFound(String)

    public var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "Invalid URL: \(url)"
        case .invalidResponse:
            return "The server returned an invalid response."
        case .unacceptableStatusCode(let statusCode, _):
            return "The server returned status code \(statusCode)."
        case .mockResponseNotFound(let url):
            return "No mock response registered for \(url)."
        }
    }
}

extension HttpMethod {
    var allowsRequestBody: Bool {
        switch self {
        case .connect, .delete, .get, .head, .options, .query, .trace:
            return false
        case .patch, .post, .put:
            return true
        }
    }
}

extension HttpClientProtocol {
    func buildURLRequest(
        url: String,
        method: HttpMethod,
        headers: [String: String]?,
        queryParams: [String: Any]?,
        body: [String: Any]?
    ) throws -> URLRequest {
        guard var components = URLComponents(string: url) else {
            throw HttpClientError.invalidURL(url)
        }

        if let queryParams, !queryParams.isEmpty {
            components.queryItems = queryParams.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
            .sorted { $0.name < $1.name }
        }

        guard let finalURL = components.url else {
            throw HttpClientError.invalidURL(url)
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue

        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        if method.allowsRequestBody, let body, !body.isEmpty {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        request.setValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }

    func decodeResponse<T: Codable>(
        _ data: Data,
        statusCode: Int?,
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> BaseResponse<T> {
        if let statusCode, !(200..<300).contains(statusCode) {
            throw HttpClientError.unacceptableStatusCode(statusCode, data)
        }

        if var baseResponse = try? decoder.decode(BaseResponse<T>.self, from: data) {
            baseResponse.httpStatusCode = statusCode
            return baseResponse
        }

        let value = try decoder.decode(T.self, from: data)
        return BaseResponse(
            status: statusCode.map(String.init),
            message: nil,
            timestamp: nil,
            httpStatusCode: statusCode,
            data: value
        )
    }
}
