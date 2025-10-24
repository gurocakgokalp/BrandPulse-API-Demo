//
//  Webservice.swift
//  BoycotApp
//
//  Created by Gökalp Gürocak on 23.10.2025.
//
import Foundation

class Webservice{
    
    func fetchDatas(url: String) async throws -> boycottResponse{
        let url = URL(string: url)
        let (data, _) = try await URLSession.shared.data(from: url!)
        let decoder = JSONDecoder()
        return try decoder.decode(boycottResponse.self, from: data)
    }
    
}

