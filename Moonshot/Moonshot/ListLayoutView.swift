//
//  GridLayoutView.swift
//  Moonshot
//
//  Created by ricky on 2024-11-18.
//

import SwiftUI

struct ListLayoutView: View {
    let astronauts: [String:Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List(missions) { mission in
            MissionListItemView(mission: mission, astronauts: astronauts)
        }
        .listStyle(.plain)
        .listRowBackground(Color.darkBackground)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    ListLayoutView(astronauts: astronauts, missions: missions)
}
