//
//  PopularVideosViewModel.swift
//  popular-pexels-ios
//
//  Created by Bruno Duarte on 30/06/23.
//

import Foundation

class PopularVideosViewModel {
    
    @Published private(set) var videos: [Video]
    @Published var searchTerm: String
    
    init(_ videos: [Video] = []) {
        self.videos = videos
        searchTerm = ""
        Task.init {
            await getPopularVideos()
        }
    }
    
    private func getPopularVideos() async {
        guard videos.isEmpty else { return }
        videos = popularVideosPreview.videos
    }
}

struct PopularVideosResponse: Decodable {
    var page: Int
    var perPage: Int
    var totalResults: Int
    var url: String
    var videos: [Video]
}
