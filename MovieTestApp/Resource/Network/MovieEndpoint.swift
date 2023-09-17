//
//  MovieEndpoint.swift
//  MovieTestApp
//
//  Created by owner on 16/09/2023.
//

import Foundation

public enum MovieEndpoint {
    case topRated
    case detailById(id: String)
    case getAll
    
    var urlString: String {
        return "https://disney-animation-movies-api.p.rapidapi.com/movies/all"
    }
    
    var apiToken: String {
        "50851df84cmsh5d8435ef5db0e23p1acbd2jsnda8e8e10990f"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var params: [String: String]? {
        switch self {
        case .detailById(let id):
            return ["id": id]
        case .getAll:
            return ["details": "true"]
        default:
            return nil
        }
    }
    
    var headers: [String: String] {
        [
            "X-RapidAPI-Key": "50851df84cmsh5d8435ef5db0e23p1acbd2jsnda8e8e10990f",
            "X-RapidAPI-Host": "disney-animation-movies-api.p.rapidapi.com"
        ]
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
