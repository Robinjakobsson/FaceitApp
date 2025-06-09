//
//  ApiCaller.swift
//  FaceitApp
//
//  Created by Robin jakobsson on 2025-06-03.
//

import Foundation
import SwiftUI

class ApiCaller {
    
    // call to faceit API to get player information
    func fetchFaceitProfile(nickname : String) async throws -> PlayerResponse {
        guard let apiKey = SecretsHandler.getApiKey() else {
            throw APIError.InvalidAPIKey
        }
                
        // BaseURL to start from and inserting a nickname
        let baseURL = "https://open.faceit.com/data/v4/players?nickname=\(nickname)"
        
        // Making the baseurl an URL
        guard let url = URL(string: baseURL) else {
            throw APIError.InvalidURL
        }
        // Specifying request to be a "GET" request
        var request = URLRequest(url : url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                throw APIError.badResponse(-1)
            }
            guard response.statusCode == 200 else {
                print("Error: Received status code: \(response.statusCode)")
                throw APIError.badResponse(response.statusCode)
            }
            let decodedPlayer = try JSONDecoder().decode(PlayerResponse.self, from: data)
            return decodedPlayer
        } catch {
            print(error.localizedDescription)
            throw APIError.decodingError
        }
    }
    
    func fetchPlayerStats(playerId: String, game: String = "cs2") async throws -> PlayerStatsResponse {
        guard let apiKey = SecretsHandler.getApiKey() else {
            throw APIError.InvalidAPIKey
        }
        
        print("starting to fetch platyer stats for \(playerId)")
        
        let now = Date()
        let toTimestamp = Int(now.timeIntervalSince1970 * 1000)
        let fromTimestamp = Int(now.addingTimeInterval(-30*24*60*60).timeIntervalSince1970 * 1000)
        
        let urlString = "https://open.faceit.com/data/v4/players/\(playerId)/games/\(game)/stats?from=\(fromTimestamp)&to=\(toTimestamp)"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            throw APIError.InvalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                throw APIError.badResponse(-1)
            }
            guard response.statusCode == 200 else {
                print("\(response.statusCode)")
                throw APIError.badResponse(response.statusCode)
            }
            let decodedPlayer = try JSONDecoder().decode(PlayerStatsResponse.self, from: data)
            
            for (index, item) in decodedPlayer.items.enumerated() {
                        print("Spelare \(index + 1):")
                        for (key, value) in item.stats {
                            print("  \(key): \(value?.value ?? "null")")
                        }
                    }
            
            return decodedPlayer
        } catch {
            print(error.localizedDescription)
            throw APIError.decodingError
        }
    }
}


