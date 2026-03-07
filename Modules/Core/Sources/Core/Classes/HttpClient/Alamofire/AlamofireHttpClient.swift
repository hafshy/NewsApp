//
//  AlamofireHttpClient.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 24/02/26.
//


import Foundation
import Alamofire

// Alamofire implementation of `HTTPClientProtocol`
public final class AlamofireHttpClient: HttpClientProtocol, @unchecked Sendable {

    private let session: Session
    private let decoder: JSONDecoder

    public init() {
        self.session = Session()
        self.decoder = JSONDecoder()
    }

    public func request<T: Codable>(
        url: String,
        method: HttpMethod,
        queryParams: [String: Any]?,
        body: [String: Any]?,
        formData: FormData?
    ) async throws -> BaseResponse<T> {

        guard let url = URL(string: url) else {
            fatalError("Invalid URL: \(url)")
        }

        let httpMethod = HTTPMethod(rawValue: method.rawValue.uppercased())

        let request: DataRequest

        // MARK: - Create Request
        if let formData {
            request = session.upload(
                multipartFormData: { multipart in
                    multipart.append(
                        formData.data,
                        withName: formData.name,
                        fileName: formData.fileName,
                        mimeType: formData.mimeType
                    )
                },
                to: url
            )
        } else {
            request = session.request(
                url,
                method: httpMethod,
                parameters: method == .get ? queryParams : body,
                encoding: method == .get ? URLEncoding.default : JSONEncoding.default
            )
        }

        // MARK: - Validate
        let result = request
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)

        // MARK: - Await Response
        let response = await result.serializingData().response

        // Network or validation error
        if let error = response.error {
            throw error
        }

        guard let data = response.data else {
            throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
        }

        // Try BaseResponse<T>
        if var base = try? decoder.decode(BaseResponse<T>.self, from: data) {
            base.httpStatusCode = response.response?.statusCode
            return base
        }

        // Fallback: T directly
        do {
            let value = try decoder.decode(T.self, from: data)
            return BaseResponse(data: value)
        } catch {
            throw error
        }
    }
}


// MARK: - Alamofire Extension
extension DataRequest {
    func responseData<T: Codable>(
        of type: T.Type,
        observer: AnyObserver<T, any Error>,
        completionHandler: @escaping (AFDataResponse<Data>) -> Void
    ) {
        self.onURLRequestCreation { _ in
            self.responseData(completionHandler: completionHandler)
        }
    }
}

