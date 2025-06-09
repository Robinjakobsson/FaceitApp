//
//  PlayerResponse.swift
//  FaceitApp
//
//  Created by Robin jakobsson on 2025-06-04.
//

import Foundation

struct PlayerResponse: Codable {
    var player_id: String
    var avatar: String?
    var country : String?
    var cover_featured_image : String?
    var cover_image : String?
    var faceit_url : String
    var verified: Bool
    var nickname: String
    let membership_type : String
    let games: [String : GameInfo]
    
    struct GameInfo : Codable {
        let faceit_elo: Int
        let game_player_id: String
        let game_player_name: String
        let region : String?
        let skill_level : Int?
        let skill_level_label : String
        
    }
}
extension PlayerResponse {
    
    var cs2Elo : Int {
        games["cs2"]?.faceit_elo ?? 1337
    }
    
    var cs2SkillLevel : Int {
        games["cs2"]?.skill_level ?? 0
    }
    var skillLevelLabel : String {
        games["cs2"]?.skill_level_label ?? ""
    }
}
