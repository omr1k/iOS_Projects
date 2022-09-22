//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Omar Khattab on 31/07/2022.
//
import SwiftUI

struct ContentView: View {

  let moves = ["Rock", "Paper", "Scissors"]
  let winOrLose = ["Win", "Lose"]

  @State var moveSlection = "paper"
  @State var winOrLoseSlection = "Win"
  @State var playerSlection = ""
  @State var counter = 0
  @State var playerScore = 0
  @State var toggleFinish = false

  @State var worning = ""

    struct GrowingButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .foregroundColor(.white)
                .scaleEffect(configuration.isPressed ? 1.2 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
                .frame(width: 100, height: 115 )
//                .background(Color(red: 0, green: 0, blue: 0.5))
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }

    
  var body: some View {
    
      
      
      ZStack{
          RadialGradient(
              stops: [
                  .init(color:.indigo,location: 0.3),
                  .init(color: .red, location: 0.3)],
              center: .top,
              startRadius: 200,
              endRadius: 700)
              .ignoresSafeArea()
          
          VStack{
              Text("Rock Paper Scissors Game")
                  .padding()
                  .font(.system(.headline, design: .rounded)).foregroundColor(.white)
              
          
          
          
          VStack {
              
              HStack{
                  Text("Round \(counter) of 8")
                      .font(.system(.title2, design: .rounded))
                    .padding()
                  
                  Text("Player Score: \(playerScore)")
                      .font(.system(.title2, design: .rounded))
                    .padding()
                  
              }
              
            Text("Device Played \n \(moveSlection)")
                  .font(.system(.title, design: .rounded))
                  .padding()
                  .multilineTextAlignment(.center)
              
              Image(moveSlection)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 250)
                  
              Text("Let Him \(winOrLoseSlection)")
                    .font(.system(.largeTitle, design: .rounded))
                    .padding()

              
              HStack{
              
                  Button(action: {
                      playerSlection = "Rock"
                      pikRand()
                  }) {
                      Image("Rock")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 100)

                  }.buttonStyle(GrowingButton())
                  
                  Button(action: {
                      playerSlection = "Paper"
                      pikRand()
                  }) {
                      Image("Paper")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 100)
                  }.buttonStyle(GrowingButton())
                  
                  Button(action: {
                      playerSlection = "Scissors"
                      pikRand()
                  }) {
                      Image("Scissors")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 100)
                  }.buttonStyle(GrowingButton())
              }
//            Button(
//              "Rock 🪨",
//              action: {
//                playerSlection = "Rock"
//                pikRand()
//
//              }
//            ).buttonStyle(GrowingButton())
//                  .padding()
//                  .frame(maxWidth:.infinity)
//                  .controlSize(.large)
//
//
//            Button(
//              "Paper 📄",
//              action: {
//                playerSlection = "Paper"
//                pikRand()
//
//              }
//            ).buttonStyle(GrowingButton())
//                  .padding()
//            Button(
//              "Scissors ✂️",
//              action: {
//                playerSlection = "Scissors"
//                pikRand()
//              }
//            ).buttonStyle(GrowingButton()).padding()
//
              
          }.onAppear { self.pikRand() }
          .alert("Game Finished",isPresented: $toggleFinish){
              Button("Reset Game",action: reset)
          } message: {
              Text("Your Score is: \(playerScore)")
          }.frame(maxWidth: .infinity)
              .padding(.vertical,20)
              .background(.thinMaterial)
              .clipShape(RoundedRectangle(cornerRadius: 50))
              .padding()
      }
      }
      
  }  // content view end

  func pikRand() {
    result()
    doesRoundFinish()
    moveSlection = moves.randomElement()!
    winOrLoseSlection = winOrLose.randomElement()!
    counter = counter + 1

  }

  func result() {

    if winOrLoseSlection == "Win" {

        
        if moveSlection == "Rock" {
            if playerSlection == "Paper" {
              playerScore = playerScore + 1
            } else {
                decrementFunc()
            }
        }
        
        if moveSlection == "Paper" {
            if playerSlection == "Scissors" {
              playerScore = playerScore + 1
            } else {
              decrementFunc()
            }
        }
        
        if moveSlection == "Scissors" {
            if playerSlection == "Rock" {
              playerScore = playerScore + 1
            } else {
                decrementFunc()
            }
        }
    }

    if winOrLoseSlection == "Lose" {
        
        
        if moveSlection == "Rock" {
            if playerSlection == "Scissors" {
              playerScore = playerScore + 1
            } else {
                decrementFunc()
            }
        }
        
        if moveSlection == "Paper" {
            if playerSlection == "Rock" {
              playerScore = playerScore + 1
            } else {
                decrementFunc()
            }
        }
        
        if moveSlection == "Scissors" {
            if playerSlection == "Paper" {
              playerScore = playerScore + 1
            } else {
                decrementFunc()
            }
        }


    }
  }
    
    func doesRoundFinish(){
        if counter >= 7{
            toggleFinish = true
        }
    }
    
    func reset(){
        counter=0
        playerScore=0
        moveSlection = moves.randomElement()!
        winOrLoseSlection = winOrLose.randomElement()!
        playerSlection = moves.randomElement()!
    }
    
    func decrementFunc(){
        if playerScore == 0{
            playerScore=playerScore
        }else{
            playerScore=playerScore-1
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}










//      if moveSlection == "Rock" && playerSlection == "Scissors" {
//        playerScore = playerScore + 1
//      } else {
//        playerScore = playerScore-1
//      }
//
//      if moveSlection == "Paper" && playerSlection == "Rock" {
//        playerScore = playerScore + 1
//      } else {
//        playerScore = playerScore-1
//      }
//
//      if moveSlection == "Scissors" && playerSlection == "Paper" {
//        playerScore = playerScore + 1
//      } else {
//        playerScore = playerScore-1
//      }






//      if moveSlection == "Rock" && playerSlection == "Paper" {
//        playerScore = playerScore + 1
//      } else {
//        playerScore = playerScore-1
//      }
//
//      if moveSlection == "Paper" && playerSlection == "Scissors" {
//        playerScore = playerScore + 1
//      } else {
//        playerScore = playerScore-1
//      }
//
//      if moveSlection == "Scissors" && playerSlection == "Rock" {
//        playerScore = playerScore + 1
//      } else {
//        playerScore = playerScore-1
//      }
