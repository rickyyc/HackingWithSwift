//
//  MissionItemView.swift
//  Moonshot
//
//  Created by ricky on 2024-11-18.
//

import SwiftUI

struct MissionListItemView: View {
    let mission: Mission
    let astronauts: [String:Astronaut]
    
    var body: some View {
        NavigationLink {
            MissionView(mission: mission, astronauts: astronauts)
        } label: {
            HStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding()
                
                VStack {
                    Text(mission.displayName)
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    Text(mission.formattedLaunchDate)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(.lightBackground)
            }
            .clipShape(.rect(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground)
            )
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    MissionListItemView(mission: missions[0], astronauts: astronauts)
}
