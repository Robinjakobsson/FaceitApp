//
//  StatisticView.swift
//  FaceitApp
//
//  Created by Robin jakobsson on 2025-06-10.
//

import SwiftUI

struct StatisticView: View {
    
    let player : PlayerResponse?
    let stats : PlayerStatsResponse?
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // Header
                HStack {
                    Image(systemName: "chart.bar.xaxis")
                        .font(.title)
                        .foregroundColor(.blue)
                    Text("Last 30 Days")
                        .font(.largeTitle)
                        .bold()
                    
                    RoundPictureView(pictureString: player?.avatar ?? "", player: player)
                }
                .padding(.horizontal)
                
                // Stat Grid
                LazyVGrid(columns: columns, spacing: 20) {
                    StatisticCard(icon: "flame.fill", value: String(player?.cs2Elo ?? 0), label: "ELO")
                    StatisticCard(icon: "scope", value: String(format: "%.2f", stats?.totalKdRatio ?? 0.0), label: "K/D Ratio")
                    StatisticCard(icon: "scope", value: String(format: "%.2f", stats?.totalKR ?? 0.0), label: "K/R Ratio")
                    StatisticCard(icon: "target", value: String(stats?.totalHeadshots ?? 0), label: "Headshots")
                    StatisticCard(icon: "target", value: String(format: "%.2f", stats?.averageADR ?? 0.0), label: "ADR")
                    StatisticCard(icon: "person.2.fill", value: String(stats?.totalAssists ?? 0), label: "Assists")
                    StatisticCard(icon: "scope", value: String(format: "%.2f",stats?.headshotPercentage ?? 0.0), label: "Headshot Percentage")
                    StatisticCard(icon: "crown.fill", value: String(stats?.mvpsTotal ?? 0), label: "Total MVPs")
                    
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

#Preview {
    StatisticView(
        player: PlayerResponse(
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
        ),
        stats: PlayerStatsResponse(
            start: 0,
            end: 0,
            items: []
        )
    )
}

struct StatisticCard: View {
    var icon: String
    var value: String
    var label: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.blue)
                    .clipShape(Circle())
                Spacer()
            }
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}
