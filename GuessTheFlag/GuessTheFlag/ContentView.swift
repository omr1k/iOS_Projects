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



    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    
    
    
    struct FlagImage: View{
        
        var flag: String
        
        var body: some View {
            Image(flag)
                .renderingMode(.original)
                .clipShape(RoundedRectangle(cornerRadius: 15, style:.circular))
                .shadow(radius: 15)
            
            }
        
    }
    
   
    

    
    

    
    
    var body: some View {
        ZStack{
            RadialGradient(
                stops: [
                    .init(color:.yellow,location: 0.3),
                    .init(color: .purple, location: 0.3)],
                center: .top,
                startRadius: 200,
                endRadius: 700)
                .ignoresSafeArea()
            
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .titleStyle()
//                        .font(.largeTitle.weight(.bold))
//                        .foregroundColor(.black)
                
            VStack(spacing:15){
                VStack{
                    Text("Tap the flag of")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.black)
                        .font(.largeTitle.weight(.semibold))

                }
                
                ForEach(0..<3){
                    number in
                    Button{
                        //flag was tapped
                        flagTapped(number)
                        counterX = counterX+1
                    } label: {
                        
                        FlagImage(flag: self.countries[number])
                        
//                        Image(countries[number]).renderingMode(.original)
//                            .clipShape(Capsule())
//                            .shadow(radius: 15)
                        
                    }
                } // for each end
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical,20)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 50))
                
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .font(.title.bold())
                
                Spacer()
                Text("Worng Answers: \(worngAnswers)")
                    .font(.title.bold())
                
                
                Text("Counter: \(counterX)")
                    .font(.title.bold())
                
            }.padding()
        }
        .alert(scoreTitle,isPresented: $showingScore){
            Button("\(alertButtontext)",action: askQ)
        } message: {
            Text("Your Score is: \(userScore)")
        }
        
    }
    
    func flagTapped (_ number: Int){
        
        if counterX == 8{
            scoreTitle = "Finished"
            alertButtontext = "Reset Game"
            showingScore = true
            counterX = 1

        }else{
            if number == correctAnswer{
                scoreTitle = "Correct"
                userScore = userScore+1
            }else{
                scoreTitle = "Worng This is actually the flag of \(countries[number])"
                worngAnswers = worngAnswers+1
                
                if worngAnswers == 3{
                    scoreTitle = "Worng!! This is actually the flag of \(countries[number]) - You failed 3 times"
                    alertButtontext = "Reset Game"
                    showingScore = true
                }
                
            }
            showingScore = true

        }
    }
    
    
    func askQ(){
        if alertButtontext == "Reset Game"{
            userScore = 0
            worngAnswers = 0
            counterX = 1
            alertButtontext = "Continue"
        }else{
            alertButtontext = "Continue"
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
