//
//  ContentView.swift
//  UrlShorterner
//
//  Created by Omar Khattab on 16/01/2023.
//

import SwiftUI
import UniformTypeIdentifiers


struct ContentView: View {
    
    @StateObject var vm = ContentViewViewModel()
    @State private var url = ""
    @State private var animate: Bool = false
    @State private var showAlert: Bool = false
    @State private var showCheckMark: Bool = false
    @State private var isShareSheetShowing: Bool = false
    
    let gradient = LinearGradient(gradient: Gradient(colors: [Color("ColorDarkAccent"), Color("ColorLightAccent")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    
    var body: some View {
        
        NavigationView() {
            ZStack(alignment: .bottom) {
                liveBackground
                VStack {
                    VStack(alignment: .center){
                        if vm.isLoading{
                            ProgressView()
                                .padding(20)
                        } else {
                            Text(vm.sortURL)
                                .padding()
                        }
                        
                        TextField("Enter Your URl", text: $url, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .cornerRadius(8)
                            .padding()
                        
                        
                        Image(systemName: "checkmark")
                            .opacity(showCheckMark ? 1.0 : 0.0)
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                            .padding()
                        
                    }
                    .shadow(radius: 15)
                    .background(.ultraThinMaterial)
                    .cornerRadius(25)
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack{
                    buttonsRow
                    shortButton
                }
                
            }
            .background(.purple)
            
            .alert("URL Field Empty", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .navigationTitle("Make your URL Shorter")
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Functions
extension ContentView {
    private func showCheck(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            withAnimation(.easeInOut){
                showCheckMark = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    withAnimation(.easeOut){
                        showCheckMark = false
                    }
                }
            }
        }
    }
    
    func shareButton() {
        
        isShareSheetShowing.toggle()
        
        let url = URL(string: vm.sortURL)
        let av = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)

    }
}

extension ContentView {
    @ViewBuilder
    private var liveBackground: some View {
        Circle().foregroundColor(.green).padding()
            .blur(radius: animate ? 40 : 100)
            .offset(x: animate ? 10 : -130 , y: animate ? -10 : -100)
            .task {
                withAnimation(.easeInOut(duration: 2).repeatForever()){
                    animate.toggle()
                }
            }
        Circle().foregroundColor(.pink).padding()
            .blur(radius: animate ? 30 : 100)
            .offset(x: animate ? 100 : 130 , y: animate ? 150 : 100)
        
    }
    
    
    private var buttonsRow: some View{
        HStack {
            Button {
                if !vm.sortURL.isEmpty {
                    UIApplication.shared.endEditing()
                    UIPasteboard.general.setValue(vm.sortURL,
                                                  forPasteboardType: UTType.plainText.identifier)
                    showCheck()
                    
                    
                }else{
                    showAlert.toggle()
                }
            } label: {
                Image(systemName: "doc.on.clipboard")
                    .modifier(ButtonModifier())
                
            }
            Button {
                showCheck()
                url = ""
                vm.sortURL = ""
            } label: {
                Image(systemName: "trash")
                    .modifier(ButtonModifier())
            }
            .padding()
            
            Button {
                
                if vm.sortURL.isEmpty{
                    showAlert.toggle()
                } else {
                    shareButton()
                }
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .modifier(ButtonModifier())
            }
            
             
            
        }
        .frame(maxWidth: .infinity)
        .background(Color.secondary)
        .cornerRadius(25)
        .padding(.horizontal)
        
    }
    
    
    private var shortButton: some View{
        Button(action: {
            if url.isEmpty{
                showAlert.toggle()
            } else {
                vm.getURL(inputURL: url)
            }
        }, label: {
            Text("Make Link Shorter")
                .padding()
        })
        .foregroundColor(.white)
        .font(.title3)
        .bold()
        .background(RoundedRectangle(cornerRadius: 15)
            .opacity(0.2))
        .padding()
    }
    
}



//                .frame(maxWidth: UIScreen.main.bounds.width / 1.3, maxHeight: UIScreen.main.bounds.width / 1)
