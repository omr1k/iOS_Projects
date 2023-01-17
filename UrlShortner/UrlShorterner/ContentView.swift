//
//  ContentView.swift
//  UrlShorterner
//
//  Created by Omar Khattab on 16/01/2023.
//

import SwiftUI
import UniformTypeIdentifiers


struct ContentView: View {
    
    @State private var url = ""
    @StateObject var vm = ContentViewViewModel()
    @State private var animate: Bool = false
    @State var showAlert: Bool = false
    @State var showCheckMark: Bool = false
    
    let gradient = LinearGradient(gradient: Gradient(colors: [Color("ColorDarkAccent"), Color("ColorLightAccent")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    
    var body: some View {
        
        ZStack {
            liveBackground
            VStack {
                VStack(alignment: .center){
                    
                    if vm.isLoading{
                        ProgressView()
                            .padding()
                    } else {
                        Text(vm.sortURL)
                            .padding()
                    }
                    
                    TextField("Enter Your URl", text: $url, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .cornerRadius(8)
                        .padding()
                    
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
                    .foregroundColor(.black)
                    .background(RoundedRectangle(cornerRadius: 15)
                        .opacity(0.2))
                    .padding()
                    
                    
                    HStack(){
                        
                        Button {
                            if !vm.sortURL.isEmpty {
                                UIApplication.shared.endEditing()
                                UIPasteboard.general.setValue(vm.sortURL,
                                            forPasteboardType: UTType.plainText.identifier)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                    withAnimation(.easeOut){
                                        showCheckMark = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                            withAnimation(.easeOut){
                                                showCheckMark = false
                                            }
                                        }
                                    }
                                }
        
                            }else{
                                showAlert.toggle()
                            }
                            
                        } label: {
                            Image(systemName: "clipboard")
                                .foregroundColor(.black)
                                .bold()
                                .font(.largeTitle)
                        }
                        .padding()
                        
                        Button {
                            url = ""
                            vm.sortURL = ""
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.black)
                                .bold()
                                .font(.largeTitle)
                        }
                        .padding()


                    }
                    
                    Image(systemName: "checkmark")
                        .opacity(showCheckMark ? 1.0 : 0.0)
                        .foregroundColor(.black)
                        .bold()
                        .font(.largeTitle)
                    
                }
                .frame(maxWidth: UIScreen.main.bounds.width / 1.3, maxHeight: UIScreen.main.bounds.width / 1)
                .shadow(radius: 15)
                .background(.ultraThinMaterial)
                .cornerRadius(25)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(.purple)
        .alert("URL Field Empty", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
    
}
