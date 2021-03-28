//
//  TeamId.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-27.
//

import Foundation

struct TeamId: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "teamId"
    }
    
    let id: Int32
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
    }
}
