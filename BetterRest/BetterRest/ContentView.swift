//
//  ContentView.swift
//  BetterRest
//
//  Created by Omar Khattab on 03/08/2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
 
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var alertStatment = "Your Recommended Bedtime is 👇"

    
    static var defaultWakeTime: Date {
            var components = DateComponents()
            components.hour = 7
            components.minute = 0
            return Calendar.current.date(from: components) ?? Date.now
        }
        
    var body: some View {
        
        NavigationView{
    
            VStack{
                Text("\(alertStatment)").font(.title2).multilineTextAlignment(.center)
                Text("\(calculateBedtime())").font(.largeTitle).multilineTextAlignment(.center)

                Form{
                    Section{
                        Text("When do you want to wake up?")
                                    .font(.headline)
                        DatePicker("Please enter a time", selection: $wakeUp,displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    Section{
                        Text("Desired amount of sleep")
                            .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in:4...12,step: 0.25)
                    }
                    
                    Section{
                        Text("Daily coffee intake")
                            .font(.headline)
//                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                        
                        Picker("Daily coffee intake", selection: $coffeeAmount) {
                                ForEach(1 ..< 21) {
                                    
                                    if $0 == 1{
                                        Text("1 Cup")
                                    }else{
                                        Text("\($0) Cups")
                                    }
                                    
//                                    Text("\($0) cups")
                                }
                        }.pickerStyle(.wheel)
                        
                    }
                    
                        
                } // forme end
            } .navigationTitle("Better Rest")//vstack end
//                .toolbar {
//                    Button("Calculate", action: calculateBedtime)
//                }
            
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }
        } //nav end
           
    }
    
    func getFinalUserMsg() -> String {
//            let model = BetterRestML()
                
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let userMsg : String
            
            do {
                let config = MLModelConfiguration()
                let model = try BetterRestML(configuration: config)
                
                let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
                
                let sleepTime = wakeUp - prediction.actualSleep

                let formatter = DateFormatter()
                formatter.timeStyle = .short
                
                userMsg = formatter.string(from: sleepTime)
            } catch {
                userMsg = "Error with calculation"
            }
            return userMsg
        }
    
    
    
    func calculateBedtime() -> String{
        let OmarVal :String
        do {
            let config = MLModelConfiguration()
            let model = try BetterRestML(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
//            alertTitle = "Your ideal bedtime is…"
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//            alertStatment = "Your Recommended Bedtime is 👇"
//
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            OmarVal = formatter.string(from: sleepTime)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            OmarVal = "omar error"
        }
//        showingAlert = true
        return OmarVal
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
