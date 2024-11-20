//
//  ContentView.swift
//  Moonshot
//
//  Created by ricky on 2024-09-19.
//

import SwiftUI


struct ContentView: View {
    @State private var showingGrid = false
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            Group {
                
                if showingGrid {
                    GridLayoutView(astronauts: astronauts, missions: missions)
                } else {
                    ListLayoutView(astronauts: astronauts, missions: missions)
                }
                
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(showingGrid ? "Show List" : "Show Grid") {
                        withAnimation {
                            showingGrid.toggle()
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
            
        }
    }
}

#Preview {
    ContentView()
}
