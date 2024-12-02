//
//  GridLayoutView.swift
//  Moonshot
//
//  Created by ricky on 2024-11-18.
//

import SwiftUI

struct ListLayoutView: View {
    let missions: [Mission]
    
    var body: some View {
        List(missions) { mission in
            MissionListItemView(mission: mission)
        }
        .listStyle(.plain)
        .listRowBackground(Color.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    ListLayoutView(missions: missions)
}
