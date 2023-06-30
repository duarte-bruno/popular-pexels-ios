//
//  VideoService.swift
//  popular-pexels-ios
//
//  Created by Bruno Duarte on 30/06/23.
//

import Foundation

class VideoService {

    func getPopularVideos(completion: @escaping (Result<PopularVideosResponse, HttpError>) -> Void) {
        let params = HttpParams(path: "videos/popular", queryParams: ["per_page": "80"])
        UrlSessionRequest.get(params, completion: completion)
    }
}
