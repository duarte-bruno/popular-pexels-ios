//
//  VideoView.swift
//  popular-pexels-ios
//
//  Created by Bruno Duarte on 30/06/23.
//

import SwiftUI
import AVKit

struct VideoView: View {
    private let viewModel: VideoViewModel
    @State private var player: AVPlayer
    
    init(_ viewModel: VideoViewModel) {
        self.viewModel = viewModel
        self.player = AVPlayer()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VideoPlayer(player: player)
                    .onAppear {
                        if let link = viewModel.video.videoFiles.first?.link, let url = URL(string: link) {
                            player = AVPlayer(url: url)
                            player.play()
                        }
                    }
            }
            .navigationBarTitle(viewModel.video.user.name, displayMode: .inline)
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = VideoViewModel(video: videoPreview)
        VideoView(viewModel)
    }
}
