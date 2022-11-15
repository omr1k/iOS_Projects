//
//  ContentView.swift
//  Flashzilla
//
//  Created by Omar Khattab on 20/10/2022.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    @State private var cards = [Card]()
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled

    
    @State private var timeRemaining = 100
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true

    @State private var showingEditScreen = false
    
    @EnvironmentObject var cardsObject : Cards
    let cardsClass = Cards()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            VStack {
                if differentiateWithoutColor || voiceOverEnabled {
                    VStack {
                        Spacer()
                        HStack {
                            Button {
                                withAnimation {
                                    removeCard(at: cards.count - 1)
                                }
                            } label: {
                                Image(systemName: "xmark.circle")
                                    .padding()
                                    .background(.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                            .accessibilityLabel("Wrong")
                            .accessibilityHint("Mark your answer as being incorrect.")
                            

                            Spacer()

                            Button {
                                withAnimation {
                                    removeCard(at: cards.count - 1)
                                }
                            } label: {
                                Image(systemName: "checkmark.circle")
                                    .padding()
                                    .background(.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                            .accessibilityLabel("Correct")
                            .accessibilityHint("Mark your answer as being correct.")
                        }
                        .padding(.horizontal,200)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    }
                }
                
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                           withAnimation {
                               removeCard(at: index)
                           }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1)
                        .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
               
                
                if cards.isEmpty {
                    Button("Start Game", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .padding()
                }

            }//.padding(.vertical,200)
        }
        .onReceive(timer) { time in
            guard isActive else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            AddView()
        }
        .onAppear(perform: loadData)
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }

        print(cards.count)
        
        cards.remove(at: index) // right
       
        let cardnew = Card(prompt: "5", answer: "5")
//        cards.insert(cardnew, at: cards.count+1)
//        cards.append(cardnew)
        
        print(index)
//        cards.insert(Card(prompt: cards[index].prompt, answer: cards[index].answer), at: 0)
        print(cards.count)
        
//        print(cards[3].prompt)
//        cards.insert(cards[index-1], at: 0)
//        print(cards[index-1])
//        print(cards[index])
//        print(cards)
//        cardsClass.add()

        
        
        if cards.isEmpty {
            isActive = false
        }
        
    }
    
    func resetCards() {
        print(FileManager.documentsDirectory)
        cards = [Card]()
        timeRemaining = 100
        isActive = true
        loadData()
    }
    func loadData(){
        let jsonFilePath = FileManager.documentsDirectory.appendingPathComponent("SavedCards")
        do {
            let data = try Data(contentsOf: jsonFilePath)
            let decoder = JSONDecoder()
            cards = try decoder.decode([Card].self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            cards = []
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
