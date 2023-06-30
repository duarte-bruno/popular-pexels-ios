//
//  Video.swift
//  popular-pexels-ios
//
//  Created by Bruno Duarte on 30/06/23.
//

import Foundation

struct Video: Identifiable, Codable {
    var id: Int
    var image: String
    var duration: Int
    var user: User
    var videoFiles: [VideoFile]
    
    struct User: Identifiable, Codable {
        var id: Int
        var name: String
        var url: String
    }
    
    struct VideoFile: Identifiable, Codable {
        var id: Int
        var quality: String
        var fileType: String
        var link: String
    }
}
