//
//  NewsArticle.swift
//  Core
//
//  Created by Hafshy Yazid Albisthami on 07/03/26.
//

import Foundation

public struct NewsArticle: Identifiable, Sendable, Hashable, Codable {
    public var id = UUID()
    public var category: String
    public var imageURL: String?
    public var headline: String
    public var summary: String
    public var author: String
    public var timestamp: String
    public var readTime: Int
    public var isBreaking: Bool
    public var isError: Bool

    enum CodingKeys: String, CodingKey {
        case category
        case imageURL
        case headline
        case summary
        case author
        case timestamp
        case readTime
        case isBreaking
        case isError
    }
    
    public init(category: String, imageURL: String? = nil, headline: String, summary: String, author: String, timestamp: String, readTime: Int, isBreaking: Bool, isError: Bool = false) {
        self.category = category
        self.imageURL = imageURL
        self.headline = headline
        self.summary = summary
        self.author = author
        self.timestamp = timestamp
        self.readTime = readTime
        self.isBreaking = isBreaking
        self.isError = isError
    }
}

public extension NewsArticle {
    static let samples: [NewsArticle] = [
        NewsArticle(
            category: "World",
            imageURL: "https://images.unsplash.com/photo-1495020689067-958852a7765e?auto=format&fit=crop&w=1200&q=80",
            headline: "Global Leaders Convene for Emergency Climate Summit in Geneva",
            summary: "Representatives from 140 nations gathered to address accelerating sea-level projections and outline binding carbon commitments for 2030.",
            author: "Elena Vasquez", timestamp: "2h ago", readTime: 4,
            isBreaking: true
        ),
        NewsArticle(
            category: "Technology",
            imageURL: "https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=1200&q=80",
            headline: "New Semiconductor Architecture Promises Tenfold Energy Efficiency",
            summary: "A breakthrough in 3D chip stacking developed at MIT could reshape data center economics and extend mobile battery life dramatically.",
            author: "James Okafor", timestamp: "4h ago", readTime: 6,
            isBreaking: false
        ),
        NewsArticle(
            category: "Finance",
            imageURL: "https://images.unsplash.com/photo-1559526324-593bc073d938?auto=format&fit=crop&w=1200&q=80",
            headline: "Central Banks Signal Coordinated Rate Pause Amid Mixed Signals",
            summary: "The Fed, ECB, and Bank of England indicated readiness to hold rates steady as inflation cools but labor markets remain surprisingly tight.",
            author: "Priya Nair", timestamp: "6h ago", readTime: 5,
            isBreaking: false,
            isError: true
        ),
        NewsArticle(
            category: "Arts",
            imageURL: "https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?auto=format&fit=crop&w=1200&q=80",
            headline: "Rediscovered Caravaggio Painting Authenticated After Decades in Private Collection",
            summary: "A long-rumored lost canvas from 1601 has been verified through multispectral imaging, setting the art world abuzz ahead of its auction.",
            author: "Marco Bellini", timestamp: "9h ago", readTime: 3,
            isBreaking: false
        ),
        NewsArticle(
            category: "Science",
            imageURL: "https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?auto=format&fit=crop&w=1200&q=80",
            headline: "Mars Soil Sample Analysis Reveals Complex Organic Compounds",
            summary: "Data transmitted from the Perseverance rover points to a richer-than-expected chemical history, fueling debate about ancient habitability.",
            author: "Dr. Yuki Tanaka", timestamp: "12h ago", readTime: 7,
            isBreaking: false
        ),
        NewsArticle(
            category: "Health",
            imageURL: "https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=1200&q=80",
            headline: "Large-Scale Trial Shows mRNA Platform Effective Against Aggressive Cancers",
            summary: "Phase III results for a personalized tumour vaccine show a 44% reduction in recurrence rates across three cancer types.",
            author: "Amara Osei", timestamp: "1d ago", readTime: 8,
            isBreaking: false
        )
    ]
}
