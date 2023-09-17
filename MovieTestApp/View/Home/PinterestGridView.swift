//
//  PinterestGridView.swift
//  MovieTestApp
//
//  Created by owner on 16/09/2023.
//

import SwiftUI

struct GridItem: Identifiable {
    let id = UUID()
    
    var height: CGFloat
    var title: String
}

struct PinterestGridView: View {
    
//    @ObservedObject var vm = HomeViewViewModel()
    @EnvironmentObject private var vm: HomeViewViewModel
    
    let spacing: CGFloat = 10
    let horizontalPadding: CGFloat = 10
    
    @State var isLinkActive = false
    
    
    var body: some View {
        HStack(alignment: .top, spacing: spacing) {
            
            if $vm.movies.count > 0 {
                ForEach($vm.movies, id: \.self) { mov in
                    LazyVStack(spacing: spacing) {
                        ForEach(mov, id: \.movieID) { movItem in
                            
                            NavigationLink {
                                // destination view to navigation to
                                HomeDetailView(vm: HomeDetailViewViewModel(movie: movItem.wrappedValue))
                            } label: {
                                PinterestItemView(vm: PinterestItemViewViewModel(title: movItem.wrappedValue.title, urlString: movItem.wrappedValue.image))
                                    .frame(height: CGFloat.random(in: 150 ... 250))
                            }
                        }
                    }
                }
            } else {
                Text("No data")
            }
        }
        .padding(.horizontal, horizontalPadding)
        .onAppear() {
            if !vm.isFetchedData {
                vm.fetchingData()
            }
        }
    }
}

struct PinterestGridView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
