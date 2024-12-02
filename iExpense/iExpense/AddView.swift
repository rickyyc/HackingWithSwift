//
//  AddView.swift
//  iExpense
//
//  Created by ricky on 2024-07-12.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Environment(\.dismiss) var dismiss
    
    var expensesDict: [String: Expenses]

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
//            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", systemImage: "checkmark") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        if let dict = expensesDict[type] {
                            dict.items.append(item)
                        }
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        dismiss()
                    }
                }
                
            }
            .navigationBarBackButtonHidden()
            
        }
    }
}

#Preview {
    AddView(expensesDict: [:])
}
