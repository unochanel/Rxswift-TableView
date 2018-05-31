//
//  QitaCodable.swift
//  Qita-ios-master
//
//  Created by 宇野凌平 on 2018/05/29.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import Foundation

struct QitaRssGet: Codable {
    var tags: [Tag]
    var title: String
    var url: String
    var user: User
    
    enum CodingKeys: String, CodingKey {
        case tags
        case title
        case url
        case user
    }
    
    public init (ftom decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tags = try container.decode([Tag].self, forKey: .tags)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)
        user = try container.decode(User.self, forKey: .user)
    }
    struct Tag: Codable {
        var name: String
        
        enum CodingKeys: String, CodingKey {
            case name
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: .name)
        }
    }
    
    struct User: Codable {
        var profileImageUrl: String
        
        enum CodingKeys: String, CodingKey {
            case profileImageUrl = "profile_image_url"
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            profileImageUrl = try container.decode(String.self, forKey: .profileImageUrl)
        }
        
    }
    
}
