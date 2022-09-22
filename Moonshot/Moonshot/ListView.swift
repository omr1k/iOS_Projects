//
//  ListView.swift
//  Moonshot
//
//  Created by Omar Khattab on 20/08/2022.
//

import SwiftUI

struct ListView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let rows = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView() {
            VStack {
                ForEach(missions) { mission in
                    NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                            HStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.clear)
                                
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                    }
                }
                
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
