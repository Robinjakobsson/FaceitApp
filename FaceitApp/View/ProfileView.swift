//
//  ProfileView.swift
//  FaceitApp
//
//  Created by Robin jakobsson on 2025-05-31.
//

//MARK: Att göra:
// 2: Visa en lista av matcher som sidan man anländer till :
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
                    VStack( spacing: 20) {
                        Text("\(player?.nickname ?? "")")
                            .font(.title)
                        
                        Text("Elo: \(player?.cs2Elo ?? 0)")
                            .font(.subheadline)
                    }
                    .padding(.trailing, 100)
                    
                    RoundPictureView(pictureString: player?.avatar ?? "", player: player)
                    
                    
                }
                
                Divider()
                    .background(.white)
                    .padding(.horizontal)
                Text("Previous Matches")
                
                // List of matches
                if let matches = matches {
                    List(matches) { match in
                        MatchRow(match: match)
                    }
                    
                }
                
                Spacer()
            }
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
