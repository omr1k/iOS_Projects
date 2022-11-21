//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Omar Khattab on 20/11/2022.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort

    @State private var showingFacilityInfo = false
    @State private var selectedFacility = ""
    @State private var selectedFacilityDescription = ""
    
    
    
    @EnvironmentObject var favorites: Favorites

    var isFave : Bool{
        if favorites.contains(resort){
            
            return false
        }else{
            
            return true
        }
    }
    
    
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
    
    func FacilityIcon (facility : String) -> String {
        switch facility {
        case "Accommodation":
            return "house"

        case "Beginners":
            return "1.circle"

        case "Cross-country":
            return "map"

        case "Eco-friendly":
            return "leaf.arrow.circlepath"
            
        case "Family":
            return "person.3"
            
        default:
            return "plus"
        }
    }
    
    
    func FacilityDescription (facility : String) -> String {
        switch facility {
        case "Accommodation":
            return "This resort has popular on-site accommodation."

        case "Beginners":
            return "This resort has lots of ski schools."

        case "Cross-country":
            return "This resort has many cross-country ski routes."

        case "Eco-friendly":
            return "This resort has won an award for environmental friendliness."
            
        case "Family":
            return "This resort is popular with families."
            
        default:
            return "This resort has other facilities you can explore yourself "
        }
    }
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                ZStack(alignment: .bottomTrailing){
                
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    HStack{
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                            .offset(x: 5, y: -5)
                        Spacer()
                        Text(resort.imageCredit)
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(.black.opacity(0.75))
                            .clipShape(Capsule())
                            .offset(x: -5, y: -5)

                    }
                    
                }
                
                
                HStack{
                    Spacer()
                    Group{
                        VStack {
                            Text("Elevation")
                                .font(.caption.bold())
                                .foregroundColor(.white)
                            Text("\(resort.elevation)m")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        VStack {
                            Text("Snow")
                                .font(.caption.bold())
                                .foregroundColor(.white)
                            Text("\(resort.snowDepth)cm")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Group {
                        Spacer()
                        VStack {
                            Text("Size")
                                .font(.caption.bold())
                                .foregroundColor(.white)
                            Text(size)
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        VStack {
                            Text("Price")
                                .font(.caption.bold())
                                .foregroundColor(.white)
                            Text(price)
                                .font(.title3)
                                .foregroundColor(.white)
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

                    HStack{
                        ForEach(resort.facilities, id: \.self){ facility in
                            
                            Button {
                                selectedFacility = facility
                                selectedFacilityDescription = FacilityDescription(facility: facility)
                                showingFacilityInfo = true
                            } label: {
                                Image(systemName: FacilityIcon(facility: facility))
                                    .font(.title)
                            }
                        }
                        
                    }
                }
                .padding(.horizontal)
            }
        }
        
        .alert( selectedFacility, isPresented: $showingFacilityInfo) {
        } message: {
            Text(selectedFacilityDescription)
        }
        
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                if favorites.contains(resort) {
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
            } label: {
                Label("Show", systemImage: "heart.fill")
                    .foregroundColor(favorites.contains(resort) ? .red : .secondary)
            }
        }
    }
}


//                    Text(resort.facilities, format: .list(type: .and))
//                        .padding(.vertical)
