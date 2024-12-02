//
//  ContentView.swift
//  iExpense
//
//  Created by ricky on 2024-06-26.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

extension Expenses {
    public static let personal = "Personal"
    public static let business = "Business"
}

@Observable
class Expenses {
    private let key: String
    
    init(_ key: String) {
        self.key = key
        
        if let savedItems = UserDefaults.standard.data(forKey: key) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: key)
            }
        }
    }
}

struct ContentView: View {
    @State private var expenses = [Expenses.personal: Expenses(Expenses.personal), Expenses.business: Expenses(Expenses.business)]
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(expenses[Expenses.personal]?.items ?? []) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundColor(getColor(item.amount))
                                .fontWeight(.heavy)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeItems(key: Expenses.personal, at: indexSet)
                    })
                }
                
                Section {
                    ForEach(expenses[Expenses.business]?.items ?? []) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundColor(getColor(item.amount))
                                .fontWeight(.heavy)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeItems(key: Expenses.business, at: indexSet)
                    })
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
//                Button("Add Expense", systemImage: "plus") {
//                    showingAddExpense = true
//                }
                NavigationLink {
                    AddView(expensesDict: expenses)
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
//            .sheet(isPresented: $showingAddExpense) {
//                AddView(expensesDict: expenses)
//            }
        }
    }
    
    func removeItems(key: String, at offsets: IndexSet) {
        expenses[key]?.items.remove(atOffsets: offsets)
    }
    
    func getColor(_ amount: Double) -> Color {
        if amount > 100 {
            return .yellow
        } else if amount > 1000 {
            return .red
        } else {
            return .green
        }
    }
    
}
#Preview {
    ContentView()
}
