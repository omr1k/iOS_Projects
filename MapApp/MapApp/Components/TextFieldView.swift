//
//  TextFieldView.swift
//  MapApp
//
//  Created by Omar Khattab on 16/02/2023.
//

import SwiftUI

struct TextFieldView: View {
    
    @Binding var inputText: String
    var placeHolder: String
    var body: some View {
        
        HStack{
            TextField("", text: $inputText)
                .placeholder(when: inputText.isEmpty) {
                    Text(placeHolder)
                        .foregroundColor(.gray)
                        .font(.system(.footnote, design: .rounded))
                }
                .foregroundColor(Color.primary)
//                .autocorrectionDisabled(true)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 10)
            Image(systemName: "trash.fill")
                .padding([.leading, .top, .bottom])
                .foregroundColor(Color.primary)
                .opacity(inputText.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                    inputText = ""
                }
                .padding(.horizontal, 10)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .shadow(
            color: Color.black.opacity(0.6),
            radius: 15,x: 0, y: 0)
        .padding(.horizontal, 10)
        
        
        
//        TextField("", text: $inputText)
//            .placeholder(when: inputText.isEmpty) {
//                Text(placeHolder)
//                    .foregroundColor(.gray)
//                    .font(.system(.footnote, design: .rounded))
//            }
//                .foregroundColor(Color.primary)
//                .autocorrectionDisabled(true)
//                .overlay(
//                    Image(systemName: "trash.fill")
//                        .padding([.leading, .top, .bottom])
//                        .foregroundColor(Color.primary)
//                        .opacity(inputText.isEmpty ? 0.0 : 1.0)
//                        .onTapGesture {
//                            UIApplication.shared.endEditing()
//                            inputText = ""
//                        }
//                    ,alignment: .trailing
//                )
//
//        .font(.headline)
//        .padding()
//        .background(
//        RoundedRectangle(cornerRadius: 15)
//            .fill(.ultraThinMaterial)
//            .shadow(
//                color: Color.black.opacity(0.6),
//                radius: 15,x: 0, y: 0)
//        )
//        .padding(.horizontal, 7)
        
    }
    
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.red
            TextFieldView(inputText: .constant("test"),placeHolder: "tesst")
                
        }.ignoresSafeArea()
    }
}
