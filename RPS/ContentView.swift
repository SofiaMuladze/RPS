//
//  ContentView.swift
//  RPS
//
//  Created by Sofia Muladze on 07/09/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var moves = ["1Rock", "2Paper", "3Scissors"]//array img
    @State private var computerMove = Int.random(in: 0...2)//mossa computer
    @State private var playerShouldWin = Bool.random()//random win lose
    @State private var score = 0//punteggio di partenza
    @State private var round = 1//round di partenza
    
    @State private var alertTitle = ""//richiama titolo avviso string
    @State private var alertMessage = ""//messaggio avviso string
    @State private var showingAlert = false
    
    let rounds = 10 //tot num round
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text("score\t\t\t\t Round")
                .font(.system(size: 20))
                .fontWeight(.medium)
            Text("\(score)\t\t\t\t\t \(round)/\(rounds)")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.bottom, 50)
        }
        
        
        VStack(spacing: 50) {
            
            VStack(spacing: 15) {
                Text("It's")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                Image(self.moves[computerMove])//scelta computer
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            
            VStack(spacing: 14.0) {
                Text("You need to")
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                Text(playerShouldWin ? "WIN" : "LOSE")//bool tra win e lose
                    .foregroundColor(playerShouldWin ? Color(.green) : Color(.red))
                    .font(.system(size: 50))
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
            }
            
            HStack(spacing: 10) {
                ForEach(0 ..< moves.count) { number in//ciclo da 0 agli elementi di moves
                    Button(action: {
                        self.buttonTapped(number)//richiama funzione
                        self.round += 1//aggiunge 1 a round
                    }) {
                        Image(self.moves[number])//icone moves
                            .resizable()
                            .frame(width: 120, height: 120)
                    }
                }
            }
            
            .alert(isPresented: $showingAlert) {//allarme
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text(round > 10 ? "Restart" : "Continue")) {
                    self.playAgain()//richiama funzione
                })
            }
            
        }
    }
        
    
    func playAgain() {//funzione che randomizza CM e PSW
        computerMove = Int.random(in: 0...2)
        playerShouldWin = Bool.random()
    }
    
    
    func buttonTapped(_ number: Int) {//funzione condizioni del gioco
        
//      pareggio
        if computerMove == number {
            alertTitle = "OK🙈!"
            alertMessage = "+ 0 Point."
        }
//      se deve vincere
        else if (computerMove == 0 && number == 1 && playerShouldWin == true) || (computerMove == 1 && number == 2 && playerShouldWin == true) || (computerMove == 2 && number == 0 && playerShouldWin == true) {
            score += 1
            alertTitle = "You Win!🐵"
            alertMessage = "+ 1 Point"
        }
//      se deve perdere
        else if (computerMove == 0 && number == 2 && playerShouldWin == false) || (computerMove == 1 && number == 0 && playerShouldWin == false) || (computerMove == 2 && number == 1 && playerShouldWin == false) {
            score += 1
            alertTitle = "You Lose, But 🙊!"
            alertMessage = "+ 1 Point"
        }
//      qualsiasi altra mossa
        else {
            score -= 1
            alertTitle = "NO 🙈."
            alertMessage = "- 1 Point"
        }
//      una volta arrivato al 10 round reset
        if round >= 10 {
            print(round)
            alertTitle = "Game Over! Your score is \(score)"
            alertMessage = "Do you want to play it again?"
            score = 0
            round = 0
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
