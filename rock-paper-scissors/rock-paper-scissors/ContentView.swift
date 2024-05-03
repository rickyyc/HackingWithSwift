//
//  ContentView.swift
//  rock-paper-scissors
//
//  Created by ricky on 2024-03-08.
//

import SwiftUI

enum Outcome: String {
    case win = "win"
    case lose = "lose"
    case neutral = "neutral"
}

extension Outcome {
    init() {
        self = .win
    }
    
    init(_ value: Bool) {
        if value {
            self = .win
        } else {
            self = .lose
        }
    }
}

enum Move: String {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}

struct ContentView: View {
    @State private var choices = [Move.rock, Move.paper, Move.scissors].shuffled()
    @State private var shouldWin = Bool.random()
    @State private var currentChoice = Int.random(in: 0...2)
    @State private var finalOutcome: Outcome = .neutral
    
    @State private var questionCount = 0
    @State private var score = 0
    
    @State private var showGameOverDialog = false
    
    private let MAX_QUESTIONS = 10
    
    var body: some View {
        ZStack {
            VStack {
                Text("Rock, Paper, Scissors")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                VStack {
                    Spacer()
                    Text("Move \(questionCount)/\(MAX_QUESTIONS):")
                        .font(.headline)
                    Text("\(choices[currentChoice].rawValue.uppercased())")
                        .font(.callout)
                    Spacer()
                }
                Spacer()
                VStack {
                    Text("Select a move to \(Outcome(shouldWin).rawValue):")

                    ForEach(choices, id: \.self) {choice in
                        Button {
                            handleMoveSelection(choice)
                        } label: {
                            Text(choice.rawValue.uppercased())
                        }
                    }
                }
                .buttonStyle(.bordered)
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
            .padding()
        }
        .alert("Game Over", isPresented: $showGameOverDialog) {
            Button("OK") {
                questionCount = 0
                score = 0
            }
        } message: {
            Text("Game over. Your final score is \(score)")
        }
    }
    
    fileprivate func handleMoveSelection(_ choice: Move) {
        let result = isWinning(input: choice, opponent: choices[currentChoice])
        
        if Outcome(shouldWin) == result {
            finalOutcome = .win
            score += 1
        }
        else {
            finalOutcome = .lose
            score -= 1
        }
        
        questionCount += 1
        
        currentChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
        
        if questionCount >= MAX_QUESTIONS {
            showGameOverDialog = true
        }
    }
    
    fileprivate func generateCurrentChoiceType() -> Move {
        return choices[Int.random(in: 0..<choices.count)]
    }
    
    fileprivate func isWinning(input: Move, opponent: Move) -> Outcome {
        if input == .paper && opponent == .rock {
            return .win
        }
        
        if input == .rock && opponent == .scissors {
            return .win
        }
        
        if input == .scissors && opponent == .paper {
            return .win
        }
        
        return .lose
    }
}

#Preview {
    ContentView()
}
