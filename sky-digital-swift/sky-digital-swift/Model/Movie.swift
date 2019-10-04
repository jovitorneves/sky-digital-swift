//
//  Movie.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 04/10/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var title: String?
    var overview: String?
    var duration: String?
    var releaseYear: String?
    var coverURL: String?
    var backdropsURL: [String]?
    var id: String?

    enum CodingKeys: String, CodingKey {
        case title, overview, duration
        case releaseYear = "release_year"
        case coverURL = "cover_url"
        case backdropsURL = "backdrops_url"
        case id
    }
}
