//
//  Boycott.swift
//  BoycotApp
//
//  Created by Gökalp Gürocak on 23.10.2025.
//

import Foundation

struct boycottResponse: Decodable{
    let success: Bool
    let data: [Brand]
    //let totalCount: Int
}

struct Brand: Decodable {
    let name: String
    let image: String
    let websites: [Websites]
}

struct Websites: Decodable {
    let websiteId: Int
    let isBoycotting: Bool
    let website: website
}

struct website: Decodable{
    let name: String
    let url: URL
    let favicon: String
}
