//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Omar Khattab on 23/07/2022.
//

import SwiftUI

struct Title: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundColor(.black)
      .padding()
      .clipShape(RoundedRectangle(cornerRadius: 10))
  }
}

extension View {
  func titleStyle() -> some View {
    modifier(Title())
  }
}

struct ContentView: View {

  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var userScore = 0
  @State private var worngAnswers = 0

  @State private var counterX = 1
  @State private var alertButtontext = "Continue"
    
  @State var countries = [
    "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain",
    "UK", "US",
  ].shuffled()
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
  @State var correctAnswer = Int.random(in: 0...2)

    @State private var isRotated = false
    @State private var isFade = false

    @State private var animationAmount = 0.0
    
    @State private var numberX = 0

  struct FlagImage: View {

    var flag: String

    var body: some View {
      Image(flag)
        .renderingMode(.original)
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
        .shadow(radius: 15)

    }

  }

  var body: some View {
    ZStack {
      RadialGradient(
        stops: [
          .init(color: .yellow, location: 0.3),
          .init(color: .purple, location: 0.3),
        ],
        center: .top,
        startRadius: 200,
        endRadius: 700
      )
      .ignoresSafeArea()

      VStack {
        Spacer()
        Text("Guess the Flag")
          .titleStyle()
        //                        .font(.largeTitle.weight(.bold))
        //                        .foregroundColor(.black)

        VStack(spacing: 15) {
          VStack {
            Text("Tap the flag of")
              .foregroundStyle(.secondary)
              .font(.subheadline.weight(.heavy))
            Text(countries[correctAnswer])
              .foregroundColor(.black)
              .font(.largeTitle.weight(.semibold))

          }

          ForEach(0..<3) {
            number in
            Button {
              //flag was tapped
                self.isRotated.toggle()
              flagTapped(number)
              counterX = counterX + 1
            } label: {

              FlagImage(flag: self.countries[number])
                    .accessibilityLabel(labels[countries[number], default: "Unknown flag"])

              //                        Image(countries[number]).renderingMode(.original)
              //                            .clipShape(Capsule())
              //                            .shadow(radius: 15)

            }
            .rotation3DEffect(.degrees(isRotated ? 360:0), axis: (x: 0, y: 1, z: 0))
                  .animation(.easeInOut(duration: 0.5), value: isRotated)
                  .opacity(self.showingScore && number != self.correctAnswer ? 0.25 : 1.0)
//                  .rotationEffect(Angle.degrees(self.showingScore && number != self.correctAnswer ? 90 : 0))
                  .scaleEffect(self.showingScore && number != self.correctAnswer ? 2 : 1)
                  
              

//                  .rotation3DEffect(.degrees(isRotated ? 360:0), axis: (x: 0, y: 1, z: 0))
//                        .animation(.easeInOut(duration: 0.5), value: isRotated)
              
//                  .rotation3DEffect(.degrees(n ? 360:0), axis: (x: 1, y: 0, z: 0))
//                  .opacity(self.wrongAnswer && number != self.correctAnswer ? 0.25 : 1)
                                     
              
//                  .animation(.default)
          }
          

            //  .rotationEffect(Angle.degrees(isRotated ? 180 : 0))
         
  // for each end
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 50))

        Spacer()
        Spacer()
        Text("Score: \(userScore)")
          .font(.title.bold())
          .foregroundColor(.white)

        Spacer()
        Text("Worng Answers: \(worngAnswers)")
          .font(.title.bold())
          .foregroundColor(.white)

//        Text("Counter: \(counterX)")
//          .font(.title.bold())

      }.padding()
    }
    .alert(scoreTitle, isPresented: $showingScore) {
      Button("\(alertButtontext)", action: askQ)
    } message: {
      Text("Your Score is: \(userScore)")
    }

  }

  func flagTapped(_ number: Int) {
      
    if counterX == 8 {
      scoreTitle = "Finished"
      alertButtontext = "Reset Game"
      showingScore = true
      counterX = 1

    } else {
      if number == correctAnswer {
        scoreTitle = "Correct"
        userScore = userScore + 1
          numberX = number
          
      } else {
        scoreTitle = "Worng This is actually the flag of \(countries[number])"
        worngAnswers = worngAnswers + 1
          numberX=number


        if worngAnswers == 3 {
          scoreTitle =
            "Worng!! This is actually the flag of \(countries[number]) - You failed 3 times"
          alertButtontext = "Reset Game"
          showingScore = true
        }

      }
      showingScore = true
        

    }
  }
  func askQ() {
    if alertButtontext == "Reset Game" {
      userScore = 0
      worngAnswers = 0
      counterX = 1
      alertButtontext = "Continue"
      countries.shuffle()
      isRotated.toggle()
    } else {
      alertButtontext = "Continue"
      countries.shuffle()
      correctAnswer = Int.random(in: 0...2)
      isRotated.toggle()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
