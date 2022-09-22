//
//  ContentView.swift
//  TemperatureConversion
//
//  Created by Omar Khattab on 22/07/2022.
//

import SwiftUI

struct ContentView: View {

    @State private var inputTemp = 0.0
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    @State private var degreeLetter = ""
  @FocusState private var Focused: Bool

  let inputUnits = ["Celsius", "Fahrenheit", "Kelvin"]
  let outputUnits = ["Celsius", "Fahrenheit", "Kelvin"]

    
//    var convertedDegreeC2F: Int {
//            let inputDegree = inputTemp
//
//            let convertC2F = Int(inputDegree/5*9+32)
//            let convertC2K = Double(inputDegree) + 273.15
//
//            let convertF2C = Int((inputDegree-32)*5/9)
//            let convertF2K = Double((inputDegree-32)*5/9+273.15)
//
//            let convertK2C = Double(inputDegree) - 273.15
//            let convertK2F = Double(1.8*(inputDegree-273)+32)
//
//
//            if inputUnit == 0 && outputUnit == 1 {
//                   return convertC2F
//            }else if inputUnit == 0 && outputUnit == 2{
//                    return Int(convertC2K)
//            }else if inputUnit == 1 && outputUnit == 0{
//                return convertF2C
//            }else if inputUnit == 1 && outputUnit == 2{
//                return Int(convertF2K)
//            }else if inputUnit == 2 && outputUnit == 0{
//                return Int(convertK2C)
//            }else if inputUnit == 2 && outputUnit == 1{
//                return 0//Int(convertK2F)
//            }
//
//        return inputDegree
//        }

    
    
    var convertedDegreeV2: Double {
            let inputDegree = inputTemp
        
            let convertC2F = Double(inputDegree/5*9+32)
            let convertC2K = Double(inputDegree) + 273.15
        
            let convertF2C = Double((inputDegree-32)*5/9)
            let convertF2K = Double((inputDegree-32)*5/9+273.15)
                
            let convertK2C = Double(inputDegree) - 273.15
            let convertK2F = Double(1.8*(inputDegree-273)+32)

        
            if inputUnit == 0 && outputUnit == 1 {
                   return convertC2F
            }else if inputUnit == 0 && outputUnit == 2{
                    return(convertC2K)
            }else if inputUnit == 1 && outputUnit == 0{
                return convertF2C
            }else if inputUnit == 1 && outputUnit == 2{
                return (convertF2K)
            }else if inputUnit == 2 && outputUnit == 0{
                return (convertK2C)
            }else if inputUnit == 2 && outputUnit == 1{
                return (convertK2F)
            }
        
        return inputDegree
        }
    
    
  var body: some View {
    NavigationView {
      Form {
        Section {

          HStack {

            TextField("First Value", value: $inputTemp, format: .number)
              .keyboardType(.numberPad)
              .focused($Focused)

            Picker("Input Unit", selection: $inputUnit) {
              ForEach(0..<inputUnits.count) {
                Text("\(self.inputUnits[$0])°")
              }
            }.pickerStyle(.menu)
          }
        }  //section end

        Text("Convert to")

        Picker("Output Unit", selection: $outputUnit) {
          ForEach(0..<inputUnits.count) {
            Text("\(self.inputUnits[$0])°")
          }
        }.pickerStyle(.wheel)

        Section {
            Text("\(convertedDegreeV2.formatted())")
        }

      }  // form end
      .navigationTitle("Temp Converter")
      .toolbar {
        ToolbarItemGroup(placement: .keyboard) {
          Spacer()
          Button("Omar Done") {
            Focused = false
          }
        }
      }  // toolbar end
    }  // body/navigation end

  }  //view end

  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
  }
}
