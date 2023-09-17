//
//  HomeView.swift
//  MovieTestApp
//
//  Created by owner on 16/09/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                PinterestGridView()
            }.refreshable {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                vm.clearMoviesFromCoreData()
            }
            .navigationTitle("Movies")
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
