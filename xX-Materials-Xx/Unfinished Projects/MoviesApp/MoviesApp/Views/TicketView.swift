//
//  TicketView.swift
//  MoviesApp
//
//  Created by Omar Khattab on 12/12/2022.
//

import SwiftUI

struct TicketView: View {
    var body: some View {
    
        VStack(spacing: 0.0){
            
            VStack(spacing: 4.0){
                
                Text("cdnflkd")
                    .font(.title).bold()
                    
                Text("dlksdkls")
                    .font(.title3)
                Image("thor1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
            }
            .padding()
            .frame(width: 350, height: 600, alignment: .top)
            .foregroundColor(.white)
            .cornerRadius(10)
            
        }
        .shadow(radius: 90)
        
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView()
    }
}
