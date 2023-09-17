//
//  SubtitleComponent.swift
//  MovieTestApp
//
//  Created by owner on 16/09/2023.
//

import SwiftUI

struct SubtitleComponent: View {
    
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 18, weight: .medium))
            Text(subtitle)
                .font(.system(size: 15))
                .foregroundColor(.gray)
        }
        .padding(2)
    }
}

struct SubtitleComponent_Previews: PreviewProvider {
    static var previews: some View {
        SubtitleComponent(title: "Title", subtitle: "Subtitle")
    }
}
