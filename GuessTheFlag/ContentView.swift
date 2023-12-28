//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Waylan Trieu on 12/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var gameOver = false
    @State private var gameOverTitle = ""
    @State private var round = 1
    @State private var streak = 0
    @State private var streakTitle = ""
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.39, green: 0.49, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.80, green: 0.80, blue: 0.80), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Text(streakTitle)
                                
                Text("Round: \(round)/5")
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding()
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert(gameOverTitle, isPresented: $gameOver) {
            Button("Restart") {
                resetGame()
            }
        } message: {
            Text("Your final score is \(userScore)!")
        }

    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            userScore += 5 + (1*streak)
            streak += 1
            streakTitle = String(repeating: "🔥", count: streak)
        } else {
            scoreTitle = "Uh oh! That is the flag of \(countries[number])."
            streak = 0
            streakTitle = ""
        }
        showingScore = true
        
        if round >= 5 {
            gameOver = true
        } else {
            round += 1
        }
    }
    
    func askQuestion() {
            countries.remove(at: correctAnswer)
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }

    
    func resetGame() {
        countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
        correctAnswer = Int.random(in: 0...2)
        showingScore = false
        scoreTitle = ""
        userScore = 0
        gameOver = false
        gameOverTitle = ""
        round = 1
        streak = 0
        streakTitle = ""
        askQuestion()
    }

}

#Preview {
    ContentView()
}
