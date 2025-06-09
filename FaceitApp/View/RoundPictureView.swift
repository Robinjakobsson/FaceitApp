//
//  RoundPictureView.swift
//  FaceitApp
//
//  Created by Robin jakobsson on 2025-06-09.
//

import SwiftUI

struct RoundPictureView: View {
    let pictureString : String
    let player : PlayerResponse?
    
    
    var body: some View {
        AsyncImage(url: URL(string: player?.avatar ?? "")) { image in
            image.resizable()
            
        } placeholder: {
            ProgressView()
        }
        .frame(width: 100, height: 100)
        .clipShape(.circle)
        .overlay(
            Circle()
                .stroke(Color.orange)
        )
        .padding()
    }
}

#Preview {
    let mockPlayer = PlayerResponse(
        player_id: "", faceit_url: "https://www.faceit.com/en/players/MockPlayer",
        verified: true,
        nickname: "MockPlayer",
        membership_type: "premium",
        games: [
            "cs2": PlayerResponse.GameInfo(
                faceit_elo: 5,
                game_player_id: "2200",
                game_player_name: "MockCSPlayer",
                region: "EU",
                skill_level: 1,
                skill_level_label: ""
            )
        ]
    )

    RoundPictureView(
        pictureString: "https://www.faceit.com/assets/images/avatar-placeholder.png",
        player: mockPlayer
    )
}
