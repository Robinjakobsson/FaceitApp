//
//  SearchView.swift
//  FaceitApp
//
//  Created by Robin jakobsson on 2025-06-10.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewViewModel()
    @State private var nickName = ""
    @State private var isLoading = false
    @State private var showStats = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Search for a player")
                    .font(.title)
                
                TextField("Faceit Nickname", text: $nickName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                if isLoading {
                    ProgressView()
                }
                
                Button("Search") {
                    search()
                }
                .disabled(nickName.isEmpty || isLoading)
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .padding()
            .background(
                NavigationLink(
                    destination: RootView(player: viewModel.player, stats: viewModel.playerStats),
                    isActive: $showStats
                ) {
                    EmptyView()
                }
            )
            .alert("Fel", isPresented: $showErrorAlert, actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(errorMessage)
            })
        }
    }
    
    func search() {
        isLoading = true
        viewModel.fetchProfile(nickname: nickName) { success, error in
            isLoading = false
            
            if success {
                showStats = true
            } else {
                errorMessage = error ?? "Okänt fel"
                showErrorAlert = true
            }
        }
    }
}
#Preview {
    SearchView()
}

extension SearchView {
    
    class SearchViewViewModel: ObservableObject {
        let apiService = ApiCaller()
        
        @Published var player: PlayerResponse?
        @Published var playerStats: PlayerStatsResponse?
        
        func fetchProfile(nickname: String, completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
            Task {
                do {
                    let player = try await apiService.fetchFaceitProfile(nickname: nickname)
                    await MainActor.run { self.player = player }
                    
                    let stats = try await apiService.fetchPlayerStats(playerId: player.player_id)
                    await MainActor.run { self.playerStats = stats }
                    
                    await MainActor.run { completion(true, nil) }
                    
                } catch {
                    await MainActor.run {
                        completion(false, "Kunde inte hämta spelarinformation.")
                    }
                }
            }
        }
    }
}
