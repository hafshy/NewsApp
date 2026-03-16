//
//  BaseService.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 16/03/26.
//

import Foundation

open class BaseService: @unchecked Sendable {
    public let httpClient: any HttpClientProtocol

    public init(httpClient: any HttpClientProtocol = AlamofireHttpClient()) {
        self.httpClient = httpClient
    }

    public func request<T: Codable>(
        _ path: String = "",
        url: String? = nil,
        method: HttpMethod = .get,
        headers: [String: String]? = nil,
        queryParams: [String: Any]? = nil,
        body: [String: Any]? = nil,
        formData: FormData? = nil
    ) async throws -> BaseResponse<T> {
        try await httpClient.request(
            path,
            url: url,
            method: method,
            headers: headers,
            queryParams: queryParams,
            body: body,
            formData: formData
        )
    }
}
