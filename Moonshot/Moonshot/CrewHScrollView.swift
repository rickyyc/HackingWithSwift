//
//  CrewHScrollView.swift
//  Moonshot
//
//  Created by ricky on 2024-11-06.
//

import SwiftUI

struct CrewHScrollView: View {
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )

                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    let crewMember = CrewMember(role: "Commander", astronaut: Astronaut(id: "schirra", name: "Walter M. Schirra", description: "Walter Marty Schirra Jr. (March 12, 1923 – May 3, 2007) (Captain, USN, Ret.) was an American naval aviator and NASA astronaut. In 1959, he became one of the original seven astronauts chosen for Project Mercury, which was the United States' first effort to put human beings into space. On October 3, 1962, he flew the six-orbit, nine-hour, Mercury-Atlas 8 mission, in a spacecraft he nicknamed Sigma 7.\n\nAt the time of his mission in Sigma 7, Schirra became the fifth American and ninth human to travel into space. In the two-man Gemini program, he achieved the first space rendezvous, station-keeping his Gemini 6A spacecraft within 1 foot (30 cm) of the sister Gemini 7 spacecraft in December 1965. In October 1968, he commanded Apollo 7, an 11-day low Earth orbit shakedown test of the three-man Apollo Command/Service Module and the first crewed launch for the Apollo program."))
    
    CrewHScrollView(crew: [crewMember])
        .preferredColorScheme(.dark)
}

