//
//  PuzzleView.swift
//  chess 2
//
//  Created by Çiğdem Onur on 23.05.2025.
//

import SwiftUI

struct PuzzlesView: View {
    let type: PuzzleType
    let theme: Theme?
    @State private var path = NavigationPath()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("✨ You’ve unlocked all the secrets of the board! More puzzles await…")
                Button(action: { dismiss() }) {
                    Text("Done")
                }
            }
            .navigationDestination(for: Puzzle.self) { puzzle in
                PuzzleView(puzzle: puzzle, level: path.count + 1, dismiss: dismiss) {
                    if path.count == 4 {
                        dismiss()
                    }
                    else {
                        path.append(Puzzle.random(type: type, theme: theme))
                    }
                }
            }
            .onAppear {
                path.append(Puzzle.random(type: type, theme: theme))
            }
        }
    }
}
