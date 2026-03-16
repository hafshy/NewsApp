//
//  NewsArticle.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import Foundation

public struct NewsArticle: Identifiable, Sendable, Hashable, Codable {
    public let id: Int64
    public let title: String
    public let pubDate: String
    public let url: String
    public let feed: String
    public let imageURL: String?
    public let happiness: Int
    public let trusted: Double

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case title = "Title"
        case pubDate = "PubDate"
        case url = "URL"
        case feed = "Feed"
        case imageURL = "ImageURL"
        case happiness = "Happiness"
        case trusted = "Trusted"
    }

    public init(
        id: Int64,
        title: String,
        pubDate: String,
        url: String,
        feed: String,
        imageURL: String? = nil,
        happiness: Int,
        trusted: Double
    ) {
        self.id = id
        self.title = title
        self.pubDate = pubDate
        self.url = url
        self.feed = feed
        self.imageURL = imageURL
        self.happiness = happiness
        self.trusted = trusted
    }
}
