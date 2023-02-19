//
//  AddNewLocationView.swift
//  MapApp
//
//  Created by Omar Khattab on 15/02/2023.
//

import SwiftUI
import MapKit

struct AddNewLocationView: View {
    
    @EnvironmentObject private var envObj : LocationsViewModel
    @StateObject var vm : AddNewLocationViewModel
    @State private var showCheckMark: Bool = false
    @State private var showNameValidationAlert: Bool = false

    var body: some View {
        ZStack (){
            mapLayer
                .ignoresSafeArea()
            VStack{
                HStack{
                    Spacer()
                    closeSheetButton
                }
                addForm
                checkMarkView
                Spacer()
                addLocationButton
                    .alert("Please Fill Name Field!!", isPresented: $showNameValidationAlert) {
                        Button("OK", role: .cancel) { }
                    }
            }
        }
        .onAppear{
            vm.startDetectingLocation()
        }
    }
}

struct AddNewLocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension AddNewLocationView {
    private var mapLayer: some View {
        ZStack {
            Map(coordinateRegion: $vm.mapRegion)
            Image(systemName: "mappin")
                .resizable()
                .scaledToFill()
                .foregroundColor(Color.primary)
                .bold()
                .frame(width: 20, height: 20)
        }
    }
    
    private var closeSheetButton: some View {
        Button {
            envObj.showAddLocationSheet.toggle()
            vm.nameText = ""
            vm.discText = ""
        } label: {
            CircleButton(iconName: "xmark")
        }
    }
    
    private var addLocationButton: some View {
        
        Button {
            if vm.nameText.isEmpty{
                showNameValidationAlert.toggle()
            }
            else {
                vm.addLocation()
                envObj.loadSavedLocations()
                checkMarkAnimation()
                
            }
        } label: {
            CircleButton(iconName: "plus")
        }
    }
    
    private var addForm: some View {
        VStack{
            TextFieldView(inputText: $vm.nameText, placeHolder: "Location Name*")
            TextFieldView(inputText: $vm.discText, placeHolder: "Description")
        }
    }
   
    private var checkMarkView: some View {
        Image(systemName: "checkmark.circle.fill")
            .opacity(showCheckMark ? 1.0 : 0.0)
            .foregroundColor(.primary)
            .bold()
            .font(.largeTitle)
            .padding()
    }
    
    private func checkMarkAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            withAnimation(.easeInOut){
                showCheckMark = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    withAnimation(.easeOut){
                        showCheckMark = false
                    }
                    envObj.showAddLocationSheet.toggle()
                }
            }
        }
    }
    
}
