//
//  HomeDetailView.swift
//  MovieTestApp
//
//  Created by owner on 16/09/2023.
//

import SwiftUI


struct HomeDetailView: View {
    
    @StateObject var vm: HomeDetailViewViewModel
    let horizontalPadding: CGFloat = 10
    
    var body: some View {
        
        GeometryReader { geo in
            VStack(alignment: .leading) {
                
                HStack(alignment: .top) {
                    
                    Image(uiImage: vm.featuredImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.7)
                        .clipped()
                    
                    VStack(alignment: .leading) {
                        SubtitleComponent(title: "Title", subtitle: vm.title)
                        SubtitleComponent(title: "Rating", subtitle: vm.rating)
                        SubtitleComponent(title: "Director", subtitle: vm.directors)
                        SubtitleComponent(title: "Star", subtitle: vm.stars)
                    }
                }
                
                SubtitleComponent(title: "Description", subtitle: vm.description)
                Spacer()
            }
            .padding(.horizontal, horizontalPadding)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDetailView(
            vm: HomeDetailViewViewModel(
                movie: Movie.initialValues))
    }
}
