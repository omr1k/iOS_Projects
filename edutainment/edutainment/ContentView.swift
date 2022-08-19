//
//  ContentView.swift
//  edutainment
//
//  Created by Omar Khattab on 06/08/2022.
//

import SwiftUI

struct ContentView: View {
  @State private var whichTable = 2
  @State private var questionsCount = 5
  @State private var randomMultipliers = [Int]()
  @State private var answersArray = [Int]()
  @State private var score = 0
  @State private var userAnswer = ""
  @State private var counter = 1
  @State private var randomMultiplier = 0
  @State private var showScore = false
  @State private var buttonText = "Next"

  var body: some View {
    NavigationView {
      VStack {
          Text("Please select a table").font(.title2)
          
        Stepper("Number \(whichTable) Table", value: $whichTable, in: 2...12)
          .onChange(
            of: whichTable,
            perform: { (value) in
              randomMultiplier = Int.random(in: 1..<12)
            }
          )
          .padding()
          .accentColor(.red)
          .foregroundColor(.red)

        Picker("Please choose how many questions", selection: $questionsCount) {
          Text("1").tag(1)
          Text("5").tag(5)  // <3>
          Text("10").tag(10)  // <4>
          Text("20").tag(20)  // <5>

        }.padding().pickerStyle(.wheel)
              .onChange(of: questionsCount, perform:  { _ in
                  showScore = false
            resetMethod()
           })
          

        HStack {
          Text("\(whichTable) x \(String(randomMultiplier)) = ")
          TextField(
            "Answer",
            text: $userAnswer
          ).padding().keyboardType(.numberPad).animation(.easeInOut(duration: 0.2))
                

        }.padding()

        Text(showScore ? "Score: \(score) out of \(questionsCount)" : "").animation(.easeInOut(duration: 0.2))
          
          
        Spacer()

        Button {
          myMethod()
          counter = counter + 1
        } label: {
          Text("\(buttonText)")
        }

        Button {
          showScore = false
          resetMethod()
        } label: {
          Text("reset")
        }

      }
      .navigationTitle("Edutainment App").onAppear(perform: myMethod)
    }
  }

  func myMethod() {

    if counter == questionsCount {
      print("Finish every thing")
      showScore = true

    }
    if counter < questionsCount {
      let answer = whichTable * randomMultiplier

      if Int(userAnswer) == answer {
        score = score + 1
        print("correct answer")
      } else {
        print("worng answer")

      }

      print("random Multiplier \(randomMultiplier)")
      print("device anwer \(answer)")
      print("user answer \(Int(userAnswer))")

      userAnswer = ""
      randomMultiplier = Int.random(in: 1..<12)
    }

  }
    
    func resetMethod(){
        counter = 1
        score = 0
        whichTable = 2
        randomMultiplier = Int.random(in: 1..<12)
        print("rested")
    }

}  // content view end

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}








//                    ForEach(5 ..< 11) {
//                        Text("\($0) Questions")
//                    }
    
//ForEach(0..<questionsCount) {
//  number in
//  Button {
//      generatMethod()
//  } label: {
//    Text("Next")
//  }
//}





//func generatMethod(){
//
//    print("Table \(whichTable)")
//    print("Count \(questionsCount)")
//    for _ in 0..<questionsCount {
//
//
//        let randomMultiplier = Int.random(in: 1..<12)
//        multiplierInText = randomMultiplier
//        randomMultipliers.append(randomMultiplier)
//
//        let answer = whichTable*randomMultiplier
//        answersArray.append(answer)
//
//        print("randomMulityplayer is \(randomMultiplier)")
//        print("qustion answer \(answer)")
//
//
//
//    }
//    print("Mulityplayers array is \(randomMultipliers)")
//    print("Answers array is \(answersArray)")
//    print("User nswer is \(userAnswer)")
//
//}
//
//func resetMethod(){
//    randomMultipliers.removeAll()
//    answersArray.removeAll()
//
//    print("Mulityplayers array after delete is \(randomMultipliers)")
//    print("Answers array after delete is \(answersArray)")
//}
//
//func startMethod(){
//    generatMethod()
//}
