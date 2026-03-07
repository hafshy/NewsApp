//
//  BaseResponse.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 24/02/26.
//


import Foundation

public struct BaseResponse<T: Codable> {
    public var status: String?
    public var message: String?
    public var timestamp: String?
    public var httpStatusCode: Int?
    public var data: T?
}

extension BaseResponse {
    public var isSuccess: Bool {
        ["00", "01"].contains(status)
    }
}

extension BaseResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case timestamp
        case httpStatusCode
        case data
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try? container.decode(String.self, forKey: .message)
        timestamp = try? container.decode(String.self, forKey: .timestamp)
        httpStatusCode = try? container.decode(Int.self, forKey: .httpStatusCode)

        do {
            status = try container.decode(String.self, forKey: .status)
        } catch DecodingError.typeMismatch {
            status = try String(container.decode(Int.self, forKey: .status))
        }

        do {
            data = try container.decode(T.self, forKey: .data)
        } catch {
            guard self.isSuccess else { return }
        }
    }
}

public struct Nil: Codable {}
