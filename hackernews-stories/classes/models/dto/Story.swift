//
//  Story.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/8/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol StoryType {
    
    /// The item's unique id
    var id: Int { get }
    
    /// The total comments count
    var descendants: Int? { get }
    
    /// The username of the item's author
    var by: Int? { get }
    
    /// The story's score
    var score: Int? { get }
    
    /// Creation date of the item, in Unix Time
    var time: Double? { get }
    
    /// The title of the story
    var title: String? { get }
    
    /// The URL of the story
    var url: String? { get }
    
    /// Creation date of the item
    var creationDate: Date? { get }
}

struct Story: StoryType, Equatable, Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case descendants
        case by
        case score
        case time
        case title
        case url
    }
    
    let id: Int
    let descendants: Int?
    let by: Int?
    let score: Int?
    let time: Double?
    let title: String?
    let url: String?
    
    var creationDate: Date? {
        guard let time = time else { return nil }
        return Date(timeIntervalSince1970: time)
    }
    
}
