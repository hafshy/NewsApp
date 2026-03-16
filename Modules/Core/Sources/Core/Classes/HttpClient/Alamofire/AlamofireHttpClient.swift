//
//  AlamofireHttpClient.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 24/02/26.
//


import Foundation
import Alamofire

public final class AlamofireHttpClient: HttpClientProtocol, @unchecked Sendable {
    private let session: Session
    private let decoder: JSONDecoder

    public init(
        session: Session = Session(),
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

        let urlRequest = try buildURLRequest(
            url: url,
            method: method,
            headers: headers,
            queryParams: queryParams,
            body: body
        )
        let response = await session
            .request(urlRequest)
            .validate(statusCode: 200..<300)
            .serializingData()
            .response

        if let error = response.error {
            throw error
        }

        guard let data = response.data else {
            throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
        }

        return try decodeResponse(data, statusCode: response.response?.statusCode, decoder: decoder)
    }

    private func uploadMultipart<T: Codable>(
        url: String,
        method: HttpMethod,
        headers: [String: String]?,
        queryParams: [String: Any]?,
        body: [String: Any]?,
        formData: FormData
    ) async throws -> BaseResponse<T> {
        let httpMethod = HTTPMethod(rawValue: method.rawValue)

        guard let finalURL = try buildURLRequest(
            url: url,
            method: method,
            headers: headers,
            queryParams: queryParams,
            body: nil
        ).url else {
            throw HttpClientError.invalidURL(url)
        }

        let response = await session.upload(
                multipartFormData: { multipart in
                    body?
                        .sorted { $0.key < $1.key }
                        .forEach { key, value in
                            multipart.append(Data(String(describing: value).utf8), withName: key)
                        }

                    multipart.append(
                        formData.data,
                        withName: formData.name,
                        fileName: formData.fileName,
                        mimeType: formData.mimeType
                    )
                },
                to: finalURL,
                method: httpMethod,
                headers: headers.map { HTTPHeaders($0) }
            )
            .validate(statusCode: 200..<300)
            .serializingData()
            .response

        if let error = response.error {
            throw error
        }

        guard let data = response.data else {
            throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
        }

        return try decodeResponse(data, statusCode: response.response?.statusCode, decoder: decoder)
    }
}
