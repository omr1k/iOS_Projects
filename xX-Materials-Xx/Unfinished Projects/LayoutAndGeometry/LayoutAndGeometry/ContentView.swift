//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Omar Khattab on 09/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    @State private var size = 0

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        let frame = geo.frame(in: CoordinateSpace.global)
                        Text("Row #\(index), \(frame.origin.x), \(frame.origin.y), \(frame.size.width), \(frame.size.height)")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(frame.origin.y < 110 ? 0 : 1)
                        
                    }
                    .frame(height: 55)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
