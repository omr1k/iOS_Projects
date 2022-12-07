//
//  SmallAddButton.swift
//  ToDoApp
//
//  Created by Omar Khattab on 06/12/2022.
//

import SwiftUI

struct SmallAddButton: View {
    var body: some View {
        ZStack(){
            
                Circle()
                    
                .foregroundColor(.blue)
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
       
        }
        .frame(height: 80)
    }
}

struct SmallAddButton_Previews: PreviewProvider {
    static var previews: some View {
        SmallAddButton()
    }
}
