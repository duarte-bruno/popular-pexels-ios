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
    @State private var player: AVPlayer?
    
    init(_ viewModel: VideoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                if let link = viewModel.video.videoFiles.first?.link, let url = URL(string: link) {
                    player = AVPlayer(url: url)
                    player?.play()
                }
            }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = VideoViewModel(video: videoPreview)
        VideoView(viewModel)
    }
}
