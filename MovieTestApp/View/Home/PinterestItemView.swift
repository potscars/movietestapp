//
//  PinterestItemView.swift
//  MovieTestApp
//
//  Created by owner on 16/09/2023.
//

import SwiftUI

struct PinterestItemView: View {
    
    @ObservedObject var vm: PinterestItemViewViewModel
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                HStack {
                    Image(uiImage: vm.featuredImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                
                ZStack {
                    Color.black.opacity(0.8)
                    Text(vm.title)
                        .font(.system(size: 17, weight: .bold))
                        .padding(10)
                        .foregroundColor(.white)
                }
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 40)
            }
            .cornerRadius(10)
        }
    }
}

struct PinterestItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct ImageOverlay: View {
    var body: some View {
        ZStack {
            Text("Karina Aespa")
                .font(.callout)
                .padding(6)
                .foregroundColor(.white)
        }.background(Color.black)
            .opacity(0.8)
            .cornerRadius(10.0)
            .padding(6)
    }
}
