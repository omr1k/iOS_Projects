//
//  ContentView.swift
//  RollTheDice
//
//  Created by Omar Khattab on 15/11/2022.
//

import SwiftUI
import UIKit
import LocalAuthentication
import Foundation

struct ContentView: View {

  @State private var selectedNumberOFDicesValue = 1
  @State private var selectedNumberOFSidesValue = 4

  let NumberOfDices = [1, 2, 3, 4, 5, 6]
  let DicesSides = [4, 6, 8, 10, 12, 20, 100]

  @Environment(\.scenePhase) var scenePhase
  @EnvironmentObject var rollesObject: Rolles
  @StateObject private var rollesClass = Rolles()

  @State private var it = 3
  @State var timerRunning = false
  var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  @State var randomResultFinal = [Int]()

  @State private var showingDeleteAlert = false
    
  @State private var isUnlocked = false
  @State private var noBiometricsError = false
    
    

    init() {
            UITableView.appearance().backgroundColor = .clear // For tableView
            UITableViewCell.appearance().backgroundColor = .clear // For tableViewCell
        }
    
    var body: some View {
        
        if isUnlocked{
            
            NavigationView {
            VStack {
                
                List {
                    Section {
                        Picker("Please choose", selection: $selectedNumberOFDicesValue) {
                            ForEach(NumberOfDices, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                        
                    } header: {
                        Text("How Many Dices?")
                            .textCase(nil)
                    }
                    .listRowBackground(Color.clear)
                    .allowsHitTesting(timerRunning ? false : true)
                    .foregroundColor(timerRunning ? .secondary : .blue)
                    
                    Section {
                        Picker("Please choose", selection: $selectedNumberOFSidesValue) {
                            ForEach(DicesSides, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                        
                    } header: {
                        Text("How Many Sides?")
                            .textCase(nil)
                    }
                    .listRowBackground(Color.clear)
                    .allowsHitTesting(timerRunning ? false : true)
                    .foregroundColor(timerRunning ? .secondary : .blue)
                    
                }
                .scrollContentBackground(.hidden)
                .listStyle(InsetGroupedListStyle())  // disable picker collapse arrow
                
                
                
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 1,
                                                               lineCap: CGLineCap.round,
                                                               dash: [5, 5])).padding()
                    Text(randomResultFinal.map(String.init).joined(separator: "-"))
                        .font(.title.bold())
                        .foregroundColor(.white)
                }
                
                
                
                ScrollView(.vertical) {
                    Section {
                        ForEach(rollesClass.rolles.reversed()) { roll in
                            
                            HStack(spacing: 0) {
                                
                                HStack{
                                    Text("\(roll.numberOfDices)")
                                        .font(.body)
                                    
                                    Image(systemName: "dice")
                                }
                                Spacer()
                                ForEach(roll.diceResult, id: \.self) {
                                    Text("\($0) ")
                                        .font(.footnote.bold())
                                }
                                Spacer()
                                HStack{
                                    Image(systemName: "sum")
                                    Text("\(roll.total)")
                                        .font(.body)
                                }
                                
                                
                            }.padding()
                        }
                    }//.padding()
                }
                
                HStack {
                    Spacer()
                    HStack{
                        Button("Roll Dice") {
                            
                            timerRunning = true
                            simpleSuccess()
                        }
                        .allowsHitTesting(timerRunning ? false : true)
                        .foregroundColor(.white)
                        
                        Image(systemName: "dice")
                        
                    }
                    
                    Spacer()
                }
                .padding()
                .background(timerRunning ? Color.secondary.cornerRadius(8) : Color.blue.cornerRadius(8))
                .padding()
                
            }.background(Image("dice2"))
            
                .alert("Delete History!", isPresented: $showingDeleteAlert) {
                    Button("Delete", role: .destructive, action: delete)
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Are you sure?")
                }
                .preferredColorScheme(.dark)
                .navigationTitle("Roll The Dice")
                .toolbar {
                    
                    Button {
                        isUnlocked = false
                    } label: {
                        Label("Show", systemImage: "lock")
                    }
                    
                    Button {
                        showingDeleteAlert = true
                    } label: {
                        Label("Scan", systemImage: "trash")
                    }
                    
                }

        }
            .onReceive(timer) { input in
                if it > 0 && timerRunning {
                    RollDice()
                    it -= 1
                    if it == 0 {
                        save()
                       
                    }
                } else {
                    timerRunning = false
                    
                    it = 3
                }
            } // on recive end
            
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    
                } else {
                    isUnlocked = false
                }
                
            }
            
        }else {
            VStack{
                Spacer()
                HStack(alignment: .center){
                    Spacer()
                    Button("Unlock Roll The Dice App") {
                        authenticate()
                    }
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Spacer()
                }
            }.background(Image("diceLockScreen"))
            
            //            .onAppear(perform: authenticate)
    }
            

    
  }

  func simpleSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
  }

  func RollDice() {

    var arrayOfSingleDice = [Int]()
    var randomResult = [Int]()

    for i in 1...selectedNumberOFSidesValue {
      arrayOfSingleDice.append(i)
    }

    for _ in 1...selectedNumberOFDicesValue {
      let randomValue = arrayOfSingleDice.randomElement()!
      randomResult.append(randomValue)
    }

    randomResultFinal = randomResult

  }
  func save() {
    let total = randomResultFinal.reduce(0, +)
    let rollToSave = Roll(
      numberOfDices: selectedNumberOFDicesValue, diceSize: selectedNumberOFSidesValue,
      diceResult: randomResultFinal, total: total)
    rollesClass.add(rollToSave)
  }
    
    func delete(){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)

        rollesClass.DeleteAll()
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    Task { @MainActor in
                        self.isUnlocked = true
                    }
                } else {
                    Task { @MainActor in
                        self.noBiometricsError = true
                    }
                }
            }
        } else {
            Task { @MainActor in
                self.noBiometricsError = true
            }
        }
    } // authenticate method end
    
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}



//                    HStack {
//                        ForEach(randomResultFinal, id: \.self) { result in
//                            Text("\(result)")
//                                .font(.title.bold())
//                                .foregroundColor(.white)
//
//                        }
//                    }

//        ZStack{
//            Image("d")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)

//            List{
//                Text("sdgdfg").listRowBackground(Color.clear)
//                Text("sdgdfg").listRowBackground(Color.red)
//                Text("sdgdfg").listRowBackground(Color.yellow)
//                Text("sdgdfg").listRowBackground(Color.green)
//            }.background(Image("d"))
//            .listRowBackground(Color.clear)
//            .onAppear(){
//                UITableView.appearance().backgroundColor = UIColor.clear
//                UITableViewCell.appearance().backgroundColor = UIColor.clear
//            }


//        }
        
