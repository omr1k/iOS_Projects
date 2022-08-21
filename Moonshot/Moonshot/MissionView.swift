//
//  MissionView.swift
//  Moonshot
//
//  Created by Omar Khattab on 19/08/2022.
//

import SwiftUI

struct MissionView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    Text("Launch Date: \(mission.formattedLaunchDate)")
                        .font(.subheadline.bold())
                        .padding()
                    
                    VStack(alignment: .leading) {

                        CustomDivider()

                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)
                        
                        CustomDivider()

                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 2)
                        
                    }
                    .padding(.horizontal)
                    
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack {
//                            ForEach(crew, id: \.role) { crewMember in
//                                NavigationLink {
//                                    AstronautView(astronaut: crewMember.astronaut)
//                                } label: {
//                                    HStack {
//                                        Image(crewMember.astronaut.id)
//                                            .resizable()
//                                            .frame(width: 104, height: 72)
//                                            .clipShape(RoundedRectangle(cornerRadius: 15))
//                                            .overlay(
//                                                    RoundedRectangle(cornerRadius: 15)
//                                                        .stroke(.white, lineWidth: 1)
//                                                )
//
//                                        VStack(alignment: .leading) {
//                                            Text(crewMember.astronaut.name)
//                                                .foregroundColor(.white)
//                                                .font(.headline)
//                                            Text(crewMember.role)
//                                                .foregroundColor(.secondary)
//                                        }
//                                    }
//                                    .padding(.horizontal)
//                                }
//                            }
//                        }
//                    }
                    
                    CrewView(mission: mission, astronauts: astronauts)
                    
                    
                    
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}

