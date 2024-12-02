//
//  MissionItemView.swift
//  Moonshot
//
//  Created by ricky on 2024-11-18.
//

import SwiftUI

struct MissionGridItemView: View {
    let mission: Mission
    
    var body: some View {
        NavigationLink(value: mission) {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()
                
                VStack {
                    Text(mission.displayName)
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text(mission.formattedLaunchDate)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
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
    
    MissionGridItemView(mission: missions[0])
}
