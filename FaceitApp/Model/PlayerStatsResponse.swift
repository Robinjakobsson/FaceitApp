//
//  PlayerStatsResponse.swift
//  FaceitApp
//
//  Created by Robin jakobsson on 2025-06-09.
//

import Foundation

import Foundation

struct PlayerStatsResponse: Codable {
    let start: Int
    let end: Int
    let items: [PlayerStatItem]
}

struct PlayerStatItem: Codable {
    let stats: [String: StatValue?]
    
    struct StatValue: Codable {
        let value: String?
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self.value = try? container.decode(String.self)
        }
    }
}

extension PlayerStatItem {
    var kills: Int? {
        guard let statValue = stats["Kills"] else { return nil }
        guard let killsString = statValue?.value else { return nil }
        return Int(killsString)
    }
    var deaths: Int? {
        guard let statValue = stats["Deaths"] else { return nil }
        guard let deathsString = statValue?.value else { return nil }
        return Int(deathsString)
    }
    
    var killDeathRatio: Int? {
        guard let statValue = stats["K/D Ratio"] else {return nil}
        guard let kdString = statValue?.value else {return nil}
        return Int(kdString)
    }
    var killRoundRatio: Int? {
        guard let statValue = stats["K/R Ratio"] else {return nil}
        guard let krString = statValue?.value else {return nil}
        return Int(krString)
    }
    var totalRoundsPlayed: Int? {
        guard let statValue = stats["Rounds"] else {return nil}
        guard let roundString = statValue?.value else {return nil}
        return Int(roundString)
    }
    var totalHeadshots: Int? {
        guard let statValue = stats["Headshots"] else {return nil}
        guard let hsString = statValue?.value else {return nil}
        return Int(hsString)
    }
    var totalAssists : Int? {
        guard let statValue = stats["Assists"] else {return nil}
        guard let assistString = statValue?.value else {return nil}
        return Int(assistString)
    }
    var totalADR : Double? {
        guard let statValue = stats["ADR"] else {return nil}
        guard let adrString = statValue?.value else {return nil}
        return Double(adrString)
    }
    var totalMvps : Int? {
        guard let statValue = stats["MVPs"] else {return nil}
        guard let mvpString = statValue?.value else {return nil}
        return Int(mvpString)
    }
}

extension PlayerStatsResponse {
    var totalKills: Int {
        items.compactMap { $0.kills }.reduce(0, +)
    }
    var mvpsTotal : Int {
        items.compactMap {$0.totalMvps}.reduce(0, +)
    }
    
    var totalDeaths : Int {
        items.compactMap { $0.deaths }.reduce(0, +)
    }
    var totalKdRatio: Double? {
            let kills = Double(totalKills)
            let deaths = Double(totalDeaths)
            guard deaths != 0 else { return nil }
            return kills / deaths
    }
    var totalKR: Double? {
        let rounds = Double(totalRoundsPlayed)
        let kills = Double(totalKills)
        return kills / rounds
    }
    
    var totalRoundsPlayed : Int {
        items.compactMap {$0.totalRoundsPlayed}.reduce(0, +)
    }
    
    var totalHeadshots : Int {
        items.compactMap {$0.totalHeadshots}.reduce(0, +)
    }
    var totalAssists : Int {
        items.compactMap {$0.totalAssists}.reduce(0, +)
    }
    var adr : Double? {
        items.compactMap {$0.totalADR}.reduce(0, +)
        
    }
    var averageADR: Double? {
        let adrs = items.compactMap { $0.totalADR }
        guard !adrs.isEmpty else { return nil }
        return adrs.reduce(0, +) / Double(adrs.count)
    }
    var headshotPercentage: Double? {
        let headshots = Double(totalHeadshots)
        let kills = Double(totalKills)
        guard kills != 0 else { return nil }
        return (headshots / kills) * 100
    }
}
