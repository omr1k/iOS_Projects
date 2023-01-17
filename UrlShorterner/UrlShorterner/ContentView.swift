//
//  ContentView.swift
//  UrlShorterner
//
//  Created by Omar Khattab on 16/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var url = ""
    @StateObject var vm = ContentViewViewModel()
    
    var body: some View {
        
            VStack(alignment: .center){
        
                TextField("Enter Your URl", text: $url, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button("Make Link Shorter"){
                    vm.getURL(inputURL: url)
                }
                Text(vm.sortURL)
                
            }
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
