//
//  ProfileView.swift
//  FaceitApp
//
//  Created by Robin jakobsson on 2025-05-31.
//

//MARK: Att göra:
// 3: Kunna trycka in på en match och se statistik om sig själv eventuellt alla i matchen. :
// 4: Ha W-W-W-L I hemskärmen :


import SwiftUI

struct ProfileView: View {
    let player : PlayerResponse?
    let stats : PlayerStatsResponse?
    let matches : [Match]?
    @StateObject var vm = ProfileViewViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack(spacing: 20) {
                        // Nickname
                        Text(player?.nickname ?? "")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        // Elo
                        Text("Elo: \(player?.cs2Elo ?? 0)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.trailing, 100)
                    
                    RoundPictureView(pictureString: player?.avatar ?? "", player: player)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Latest Matches
                VStack(spacing: 8) {
                    HStack {
                        Text("Latest Matches")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                        
                        Spacer()
                    }
                    
                    // Gradient Divider
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.orange.opacity(0.7), .orange.opacity(0.3)],
                                startPoint: .leading,
                                endPoint: .trailing)
                        )
                        .frame(height: 3)
                        .cornerRadius(2)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // List of matches
                List(matches ?? []) { match in
                    MatchRow(match: match)
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
#Preview {
    ProfileView(
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
        ), matches: [Match(id: "1", score: "1 / 2", map: "De_Dust2", win: true)]
    )
}

extension ProfileView {
    @MainActor
    class ProfileViewViewModel : ObservableObject {
        @Published var matches : [Match] = []
        let apiService = ApiCaller()
    }
}
