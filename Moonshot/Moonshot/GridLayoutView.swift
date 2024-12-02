//
//  GridLayoutView.swift
//  Moonshot
//
//  Created by ricky on 2024-11-18.
//

import SwiftUI

struct GridLayoutView: View {
    let missions: [Mission]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    MissionGridItemView(mission: mission)
                }
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    GridLayoutView(missions: missions)
}
