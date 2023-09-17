//
//  Extension+Array.swift
//  MovieTestApp
//
//  Created by owner on 17/09/2023.
//

import Foundation

extension Array {
    func chunks(size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
