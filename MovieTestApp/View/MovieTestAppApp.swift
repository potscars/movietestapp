//
//  MovieTestAppApp.swift
//  MovieTestApp
//
//  Created by owner on 16/09/2023.
//

import SwiftUI

@main
struct MovieTestAppApp: App {
    
    @StateObject var vm = HomeViewViewModel()
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { proxy in
                HomeView()
                    .environment(\.mainWindowSize, proxy.size)
                    .environmentObject(vm)
            }
        }
    }
}
