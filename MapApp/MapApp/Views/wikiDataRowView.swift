//
//  wikiDataRowView.swift
//  MapApp
//
//  Created by Omar Khattab on 18/02/2023.
//

import SwiftUI

struct wikiDataRowView: View {
    let page: Page
    var body: some View {
        ZStack{
            Color.clear
            HStack{
                VStack(alignment: .leading, spacing: 5.0){
                    Text(page.title)
                        .font(.system(.caption, design: .rounded))
                        .bold()
                        .foregroundColor(.primary)
                    Text(page.description)
                        .font(.system(.footnote, design: .rounded))
                        .foregroundColor(.secondary)
                }
                Spacer()
                let url = "https://www.google.com/maps/@\(page.coordinates.first?.lat),\(page.coordinates.first?.lon),16z"
                ShareLink(
                    item: URL(string: url)!) {
                        VStack(spacing: 10){
                            Image(systemName: "location.north.fill")
                                .foregroundColor(.blue)
                            Text("Directions")
                                .foregroundColor(.blue)
                                .font(.footnote)
                        }
                        
                    }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .cornerRadius(5)
    }
}

//struct wikiDataRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        wikiDataRowView()
//    }
//}
