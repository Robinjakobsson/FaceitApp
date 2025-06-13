//
//  MatchRow.swift
//  FaceitApp
//
//  Created by Robin jakobsson on 2025-06-13.
//

import SwiftUI

struct MatchRow: View {
    var match : Match

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: match.win ? "checkmark.seal.fill" : "xmark.seal.fill")
                .foregroundColor(match.win ? .green : .red)
                .imageScale(.large)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Map")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(match.map)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("Score")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(match.score)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .padding()
        .frame(height: 80)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(match.win ? Color.green : Color.red, lineWidth: 2)
        )
        .padding(.horizontal)
    }
}

#Preview {
    VStack(spacing: 16) {
        MatchRow(match: Match(id: "1", score: "13/2", map: "De_Dust2", win: true))
    }
    .background(Color.black)
    .preferredColorScheme(.dark)
}
