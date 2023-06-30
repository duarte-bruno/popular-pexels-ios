//
//  PopularVideosViewModel.swift
//  popular-pexels-ios
//
//  Created by Bruno Duarte on 30/06/23.
//

import Foundation
import Combine

class PopularVideosViewModel: ObservableObject {
    
    @Published var videos: [Video] {
        didSet {
            filteredVideos = videos
        }
    }
    @Published var filteredVideos: [Video]
    @Published var searchTerm: String
    
    var publisher: AnyPublisher<Void, Never>! = nil
    
    init(_ videos: [Video] = []) {
        self.videos = videos
        self.filteredVideos = videos
        self.searchTerm = ""
        
        Task.init {
            await getPopularVideos()
        }
        
        publisher = Timer.publish(every: 1.0, on: RunLoop.main, in: .common).autoconnect().map { [weak self] _ in
            print("Updating information")
            print(self?.searchTerm ?? "")
        }.eraseToAnyPublisher()
    }
    
    func filterVideos() {
        if searchTerm.isEmpty {
            filteredVideos = videos
        } else {
            filteredVideos = videos.filter({$0.user.name.lowercased().contains(searchTerm.lowercased())})
        }
    }
    
    private func getPopularVideos() async {
        guard videos.isEmpty else { return }

        VideoService().getPopularVideos { result in
            switch result {
            case.success(let popularVideosResponse):
                self.videos = popularVideosResponse.videos
            case .failure(let error):
                print(error.description)
            }
        }
    }
}

struct PopularVideosResponse: Codable {
    var page: Int
    var perPage: Int
    var totalResults: Int
    var url: String
    var videos: [Video]
}
