//
//  ValueBoxView.swift
//  FaceitApp
//
//  Created by Robin jakobsson on 2025-06-09.
//

import SwiftUI

struct ValueBoxView: View {
    let icon: String
        let value: String
        let textInput: String

        var body: some View {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.orange)
                    .imageScale(.large)

                VStack(alignment: .leading, spacing: 4) {
                    Text(textInput)
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text(value)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(width: 180, height: 80, alignment: .leading)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.orange, lineWidth: 2)
            )
        }
    }
#Preview {
    ValueBoxView(icon: "flame.fill", value: "1", textInput: "ELO:")
}
