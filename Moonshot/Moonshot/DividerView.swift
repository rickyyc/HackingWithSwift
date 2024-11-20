//
//  DividerView.swift
//  Moonshot
//
//  Created by ricky on 2024-11-06.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    DividerView()
}
