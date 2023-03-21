//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by mac on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numberOfGuesses = 0
   
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.bold))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){number in
                        Button{
                            flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Text("Number of moves left \(8 - numberOfGuesses)")
                    .foregroundColor(.white)
                Spacer()
                Text("Score \(score)")
                    .foregroundColor(.white)
                    .font(.headline.bold())
                Spacer()
            }.padding()
            
            
        }.alert(scoreTitle, isPresented: $showingScore){
            if numberOfGuesses == 8{
                Button("Restart" , action: resetGame)
            }else{
                Button("Continue", action: askQuestion)
            }
            
        }message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number : Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
        }else{
            scoreTitle = "Wrong, That is the flag of \(countries[number])"
        }
        showingScore = true
        numberOfGuesses += 1
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func resetGame(){
        score = 0
        numberOfGuesses = 0
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
