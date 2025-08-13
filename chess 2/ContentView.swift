//
//  ContentView.swift
//  chess 2
//
//  Created by Çiğdem Onur on 23.05.2025.
//

import SwiftUI
import Chess

struct ContentView: View {
    @AppStorage("name") private var name: String = ""
    
    @State private var phase: AppState = .welcome
    @State private var theme: Theme? = nil
    
    @State private var puzzleStarted: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack(spacing: 16) {
                    Text("Welcome \(name)!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(colors: [.purple, .pink], startPoint: .leading, endPoint: .trailing))
                    
                    Text(phase == .welcome ? "Ready for some chess magic?" : phase == .pickType ?
                         "Choose your adventure!" : phase == .pickTheme ? "Pick the theme!" : "Do you want to solve themed puzzles?")
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    
                    if phase == .pickType {
                        AppButton(text: "Generated", colors: [.blue], short: false) { phase = .pickLevel }
                        AppButton(text: "Regular", colors: [.green], short: false) { phase = .pickLevel }
                    }
                    else if phase == .pickLevel {
                        AppButton(text: "Themed", colors: [.mint, .blue], short: false) { phase = .pickTheme }
                        AppButton(text: "Mixed", colors: [.orange, .yellow], short: false) { self.theme = nil; puzzleStarted = true }
                    }
                    else if phase == .pickTheme {
                        ForEach(Theme.allCases, id: \.self) { theme in
                            AppButton(text: theme.text, colors: [theme.color, theme.color.mix(with: .white, by: 0.25)], short: true) { self.theme = theme ; puzzleStarted = true }
                        }
                    }
                    else {
                        TextField("Your name", text: $name)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(LinearGradient(colors: [.purple, .pink], startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                            )
                            .padding(.horizontal)
                        AppButton(text: "Let's play!", colors: [.purple, .pink], short: false, action: play)
                    }
                }
                .padding(16)
                .padding(.vertical, 16)
                .background(.white)
                .cornerRadius(16)
                .shadow(radius: 12)
                .padding()
                .fullScreenCover(isPresented: $puzzleStarted) {
                    PuzzlesView(theme: theme)
                        .colorScheme(.light)
                }
                Spacer()
            }
            .animation(.easeInOut, value: phase)
            .background(
                LinearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    if phase != .welcome {
                        Button(action: {
                            let phases: [AppState] = [
                                .welcome, .pickType, .pickLevel, .pickTheme
                            ]
                            let index = phases.firstIndex(of: phase) ?? 1
                            self.phase = phases[index - 1]
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
    }
    
    private func play() {
        guard !name.isEmpty else {
            print("Name cannot be empty")
            return
        }
        
        phase = .pickType
    }
}


#Preview {
    ContentView()
}
