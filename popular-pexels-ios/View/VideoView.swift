//
//  VideoView.swift
//  popular-pexels-ios
//
//  Created by Bruno Duarte on 30/06/23.
//

import SwiftUI
import AVKit

struct VideoView: View {
    var video: Video
    @State private var player = AVPlayer()
    
    var body: some View {
        NavigationView {
            VStack {
                VideoPlayer(player: player)
                    .onAppear {
                        if let link = video.videoFiles.first?.link, let url = URL(string: link) {
                            player = AVPlayer(url: url)
                            player.play()
                        }
                    }
            }
            .navigationBarTitle(video.user.name, displayMode: .inline)
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(video: videoPreview)
    }
}
