//
//  ContentView.swift
//  edutainment
//
//  Created by Omar Khattab on 06/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var whichTable=2;
    @State private var questionsCount=5;
    @State private var questions=[String]();

    var body: some View {
        NavigationView{
            VStack{
                Text("Please select a mulity table")
                Stepper("Number \(whichTable) Table", value: $whichTable,in: 2...12)
                    .padding()
                
                Picker("Please choose how many questions", selection: $questionsCount) {
                                    Text("5").tag(5) // <3>
                                    Text("10").tag(10) // <4>
                                    Text("20").tag(20) // <5>
                }.padding().pickerStyle(.wheel)
                
                Button("Start"){
                    print("Table \(whichTable)")
                    print("Count \(questionsCount)")
                    startGame()
                }
            }
            .navigationTitle("Edutainment App")
        }
    }
    
    
    func startGame(){
        
        for i in 0..<questionsCount {
        
            var randomMulityplayer = Int.random(in: 1..<12)
            var qustionXX = whichTable*randomMulityplayer
            
            print("randomMulityplayer is \(randomMulityplayer)")
            print("qustion answer \(qustionXX)")
        }
        
    }
    
    
} // content view end

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//                    ForEach(5 ..< 11) {
//                        Text("\($0) Questions")
//                    }
    
