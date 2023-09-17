//
//  Movie.swift
//  MovieTestApp
//
//  Created by owner on 16/09/2023.
//

import Foundation

// MARK: - Movie
//struct Movie: Codable, Hashable {
//    let id, title, description: String
//    let link: String
//    let director, writers, stars, genre: [String]
//    let images: [[String]]
//    let imdbid: String
//    let rank: Int
//    let rating, year: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, title, description, link
//        case director = "Director"
//        case writers = "Writers"
//        case stars = "Stars"
//        case genre, images, imdbid, rank, rating, year
//    }
//
//    static let initialValues = Movie(id: "top1",
//                                     title: "The Shawshank Redemption",
//                                     description: "Over the course of several years, two convicts form a friendship, seeking consolation and, eventually, redemption through basic compassion.",
//                                     link: "https://www.imdb.com//title/tt0111161/?ref_=adv_li_tt",
//                                     director: [
//                                        "Frank Darabont"
//                                     ],
//                                     writers: [
//                                        "Stephen King",
//                                        "Frank Darabont"
//                                     ],
//                                     stars: [
//                                        "Tim Robbins",
//                                        "Morgan Freeman",
//                                        "Bob Gunton"
//                                     ],
//                                     genre: [
//                                        "Drama"
//                                     ],
//                                     images: [
//                                        [
//                                            "190",
//                                            "https://m.media-amazon.com/images/M/MV5BNDE3ODcxYzMtY2YzZC00NmNlLWJiNDMtZDViZWM2MzIxZDYwXkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_QL75_UX190_CR0,2,190,281_.jpg"
//                                        ],
//                                        [
//                                            "285",
//                                            "https://m.media-amazon.com/images/M/MV5BNDE3ODcxYzMtY2YzZC00NmNlLWJiNDMtZDViZWM2MzIxZDYwXkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_QL75_UX285_CR0,3,285,422_.jpg"
//                                        ],
//                                        [
//                                            "380",
//                                            "https://m.media-amazon.com/images/M/MV5BNDE3ODcxYzMtY2YzZC00NmNlLWJiNDMtZDViZWM2MzIxZDYwXkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_QL75_UX380_CR0,4,380,562_.jpg"
//                                        ]
//                                     ],
//                                     imdbid: "",
//                                     rank: 1,
//                                     rating: "9.3",
//                                     year: "1994")
//}

struct Movie: Codable, Hashable {
    let movieID: Int
    let title, year: String
    let image: String
    let runtime, genre, summary, rating: String
    let directors, stars: String

    enum CodingKeys: String, CodingKey {
        case movieID = "movieId"
        case title, year, image, runtime, genre, summary, rating, directors, stars
    }

    static let initialValues = Movie(movieID: 1,
                                     title: "Snow White and the Seven Dwarfs",
                                     year: "(1937)",
                                     image: "https://m.media-amazon.com/images/M/MV5BMTQwMzE2Mzc4M15BMl5BanBnXkFtZTcwMTE4NTc1Nw@@._V1_FMjpg_UX1000_.jpg",
                                     runtime: "83 min",
                                     genre: "Animation, Adventure, Family",
                                     summary: "Exiled into the dangerous forest by her wicked stepmother, a princess is rescued by seven dwarf miners who make her part of their household.",
                                     rating: "7.6",
                                     directors: "William Cottrell, \nDavid Hand, \nWilfred Jackson, \nLarry Morey, \nPerce Pearce, \nBen Sharpsteen",
                                     stars: "Adriana Caselotti, \nHarry Stockwell, \nLucille La Verne, \nRoy Atwell")
}
