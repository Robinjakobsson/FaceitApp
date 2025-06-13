//
//  RootView.swift
//  FaceitApp
//
//  Created by Robin jakobsson on 2025-06-10.
//

import SwiftUI

struct RootView: View {
    let player : PlayerResponse?
    let stats: PlayerStatsResponse?
    let matches : [Match]?
    
    var body: some View {
        TabView {
            StatisticView(player: player, stats: stats)
            .tabItem {
                Label("Statistics", systemImage: "chart.bar")
            }
            ProfileView(player: player, stats: stats, matches: matches)
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
            MatchHistoryView()
                .tabItem {
                    Label("Match history", systemImage: "clock.arrow.circlepath")
                }
        }
    }
    
    let mockPlayer = PlayerResponse(
        player_id: "123",
        avatar: nil,
        country: "SE",
        cover_featured_image: nil,
        cover_image: nil,
        faceit_url: "https://faceit.com",
        verified: true,
        nickname: "MockPlayer",
        membership_type: "Free",
        games: [:]
    )

    let mockStats = PlayerStatsResponse(
        start: 0,
        end: 0,
        items: []
    )
    
}
