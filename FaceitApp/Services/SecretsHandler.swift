//
//  SecretsHandler.swift
//  FaceitApp
//
//  Created by Robin jakobsson on 2025-06-13.
//

import Foundation

class SecretsHandler {

    static func getApiKey() -> String? {
        guard let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            return nil
        }
        return plist["API_KEY"] as? String
    }
}
