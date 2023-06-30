//
//  PopularVideosView.swift
//  popular-pexels-ios
//
//  Created by Bruno Duarte on 30/06/23.
//

import SwiftUI

struct PopularVideosView: View {
    @State private var searchTerm = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Searching for: \(searchTerm)")
            }
            .navigationBarTitle("Popular Videos", displayMode: .large)
        }
        .searchable(text: $searchTerm, prompt: "Search for videos") {
        }
    }
}

struct PopularVideosView_Previews: PreviewProvider {
    static var previews: some View {
        PopularVideosView()
    }
}
