//
//  MockHttpClient.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 16/03/26.
//

import Foundation

public final class MockHttpClient: HttpClientProtocol, @unchecked Sendable {
    public typealias ResponseProvider = @Sendable (_ request: MockRequest) throws -> MockResponse

    private let responseProvider: ResponseProvider
    private let decoder: JSONDecoder

    public init(
        decoder: JSONDecoder = JSONDecoder(),
        responseProvider: @escaping ResponseProvider
    ) {
        self.decoder = decoder
        self.responseProvider = responseProvider
    }

    public convenience init(
        responses: [MockRequest: MockResponse],
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.init(decoder: decoder) { request in
            guard let response = responses[request] else {
                throw HttpClientError.mockResponseNotFound(request.url)
            }
            return response
        }
    }

    public func request<T: Codable>(
        url: String,
        method: HttpMethod,
        headers: [String: String]?,
        queryParams: [String: Any]?,
        body: [String: Any]?,
        formData: FormData?
    ) async throws -> BaseResponse<T> {
        let request = MockRequest(
            url: url,
            method: method,
            headers: headers ?? [:],
            queryParams: queryParams?.stringified() ?? [:],
            body: body?.stringified() ?? [:],
            formDataName: formData?.name
        )
        let response = try responseProvider(request)

        return try decodeResponse(
            response.data,
            statusCode: response.statusCode,
            decoder: decoder
        )
    }
}

public struct MockRequest: Hashable, Sendable {
    public let url: String
    public let method: HttpMethod
    public let headers: [String: String]
    public let queryParams: [String: String]
    public let body: [String: String]
    public let formDataName: String?

    public init(
        url: String,
        method: HttpMethod,
        headers: [String: String] = [:],
        queryParams: [String: String] = [:],
        body: [String: String] = [:],
        formDataName: String? = nil
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.queryParams = queryParams
        self.body = body
        self.formDataName = formDataName
    }
}

public struct MockResponse: Sendable {
    public let statusCode: Int
    public let data: Data

    public init(statusCode: Int = 200, data: Data) {
        self.statusCode = statusCode
        self.data = data
    }

    public init<T: Encodable>(
        statusCode: Int = 200,
        json: T,
        encoder: JSONEncoder = JSONEncoder()
    ) throws {
        self.statusCode = statusCode
        self.data = try encoder.encode(json)
    }
}

private extension Dictionary<String, Any> {
    func stringified() -> [String: String] {
        reduce(into: [:]) { result, element in
            result[element.key] = String(describing: element.value)
        }
    }
}
