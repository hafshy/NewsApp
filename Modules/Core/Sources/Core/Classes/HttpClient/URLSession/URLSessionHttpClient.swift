//
//  URLSessionHttpClient.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 16/03/26.
//

import Foundation

public final class URLSessionHttpClient: HttpClientProtocol, @unchecked Sendable {
    private let session: URLSession
    private let decoder: JSONDecoder

    public init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }

    public func request<T: Codable>(
        url: String,
        method: HttpMethod,
        headers: [String: String]?,
        queryParams: [String: Any]?,
        body: [String: Any]?,
        formData: FormData?
    ) async throws -> BaseResponse<T> {
        if let formData {
            return try await uploadMultipart(
                url: url,
                method: method,
                headers: headers,
                queryParams: queryParams,
                body: body,
                formData: formData
            )
        }

        let request = try buildURLRequest(
            url: url,
            method: method,
            headers: headers,
            queryParams: queryParams,
            body: body
        )

        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HttpClientError.invalidResponse
        }

        return try decodeResponse(data, statusCode: httpResponse.statusCode, decoder: decoder)
    }

    private func uploadMultipart<T: Codable>(
        url: String,
        method: HttpMethod,
        headers: [String: String]?,
        queryParams: [String: Any]?,
        body: [String: Any]?,
        formData: FormData
    ) async throws -> BaseResponse<T> {
        var request = try buildURLRequest(
            url: url,
            method: method,
            headers: headers,
            queryParams: queryParams,
            body: nil
        )

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = buildMultipartBody(boundary: boundary, body: body, formData: formData)

        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HttpClientError.invalidResponse
        }

        return try decodeResponse(data, statusCode: httpResponse.statusCode, decoder: decoder)
    }

    private func buildMultipartBody(
        boundary: String,
        body: [String: Any]?,
        formData: FormData
    ) -> Data {
        var data = Data()

        body?
            .sorted { $0.key < $1.key }
            .forEach { key, value in
                data.append("--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                data.append("\(value)\r\n".data(using: .utf8)!)
            }

        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append(
            "Content-Disposition: form-data; name=\"\(formData.name)\"; filename=\"\(formData.fileName)\"\r\n".data(using: .utf8)!
        )
        data.append("Content-Type: \(formData.mimeType)\r\n\r\n".data(using: .utf8)!)
        data.append(formData.data)
        data.append("\r\n".data(using: .utf8)!)
        data.append("--\(boundary)--\r\n".data(using: .utf8)!)

        return data
    }
}
