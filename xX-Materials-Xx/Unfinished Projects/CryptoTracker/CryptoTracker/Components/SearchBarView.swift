//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 01/01/2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.theme.SecondaryTextColor : Color.theme.accent
                
                )
            
            TextField("Search", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .autocorrectionDisabled(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding([.leading, .top, .bottom])
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 55)
            .fill(Color.theme.background)
            .shadow(
                color: Color.theme.accent.opacity(0.15),
                radius: 10,x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("Test"))
//                .previewLayout(PreviewLayout.sizeThatFits)
    }
}
