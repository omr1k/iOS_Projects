//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Omar Khattab on 20/11/2022.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort

    var size: String {
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                HStack{
                    Spacer()
                    Group{
                        VStack {
                            Text("Elevation")
                                .font(.caption.bold())
                            Text("\(resort.elevation)m")
                                .font(.title3)
                        }
                        Spacer()
                        VStack {
                            Text("Snow")
                                .font(.caption.bold())
                            Text("\(resort.snowDepth)cm")
                                .font(.title3)
                        }
                    }
                    
                    Group {
                        Spacer()
                        VStack {
                            Text("Size")
                                .font(.caption.bold())
                            Text(size)
                                .font(.title3)
                        }
                        Spacer()
                        VStack {
                            Text("Price")
                                .font(.caption.bold())
                            Text(price)
                                .font(.title3)
                        }
                    }
                    
                   Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(Color.secondary)

                Group {
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)

                    Text(resort.facilities, format: .list(type: .and))
                        .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

