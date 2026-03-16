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

public extension NewsArticle {
    var publishedDate: Date? {
        Self.pubDateFormatter.date(from: pubDate)
    }

    var relativePublishedDateText: String {
        relativePublishedDateText(referenceDate: Date())
    }

    func relativePublishedDateText(referenceDate: Date) -> String {
        guard let publishedDate else {
            return pubDate
        }

        let elapsedSeconds = max(0, Int(referenceDate.timeIntervalSince(publishedDate)))
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 30 * day
        let year = 365 * day

        switch elapsedSeconds {
        case 0..<hour:
            let value = max(1, elapsedSeconds / minute)
            return "\(value) mins ago"
        case hour..<day:
            let value = elapsedSeconds / hour
            return "\(value) hours ago"
        case day..<week:
            let value = elapsedSeconds / day
            return "\(value) days ago"
        case week..<month:
            let value = elapsedSeconds / week
            return "\(value) weeks ago"
        case month..<year:
            let value = elapsedSeconds / month
            return "\(value) months ago"
        default:
            let value = elapsedSeconds / year
            return "\(value) years ago"
        }
    }

    private static let pubDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
}
