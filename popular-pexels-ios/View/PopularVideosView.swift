//
//  PopularVideosView.swift
//  popular-pexels-ios
//
//  Created by Bruno Duarte on 30/06/23.
//

import SwiftUI

struct PopularVideosView: View {
    private let viewModel: PopularVideosViewModel
    @State private var searchTerm = ""
    private var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    init(_ viewModel: PopularVideosViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    if viewModel.videos.isEmpty {
                        ProgressView()
                    } else {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.videos, id: \.id) { video in
                                NavigationLink {
                                    VideoView(VideoViewModel(video: video))
                                } label: {
                                    VideoCard(video: video)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .navigationBarTitle("Popular Videos", displayMode: .large)
        }
        .searchable(text: $searchTerm, prompt: "Search for videos") {
        }
    }
}

struct PopularVideosView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PopularVideosViewModel(popularVideosPreview.videos)
        PopularVideosView(viewModel)
    }
}
