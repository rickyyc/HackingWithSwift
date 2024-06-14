//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by ricky on 2024-06-06.
//

import SwiftUI

struct ContentView: View {
    @State private var inGamePlay = false
    @State private var multiplier = Int.random(in: 2...12)
    @State private var multipleOf = 2
    @State private var selectedNumOfQuestions = 0
    @State private var answer = ""
    @State private var currentQuestionCount = 0
    @State private var multipliers: [(id: UUID, multiplier: Int, answer: Int)] = []
    
    // used for checkmark and xmark animations
    @State private var scale = 1.0
    @State private var lastAddedMultiplierID: UUID?
    
    @FocusState private var isTextFieldFocused: Bool
    
    private let numOfQuestionsSelections = [5, 10, 20]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                if inGamePlay {
                    if currentQuestionCount < numOfQuestionsSelections[selectedNumOfQuestions] {
                        HStack {
                            Text("\(multipleOf) x \(multiplier) = ")
                            TextField("Answer", text: $answer)
                                .keyboardType(.numberPad)
                                .focused($isTextFieldFocused)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        Button("Submit") {
                                            onSubmitAnswer(answer)
                                        }
                                    }
                                }
                                .onSubmit {
                                    onSubmitAnswer(answer)
                                }
                        }
                    }
                    List {
                        ForEach(multipliers, id:\.id) { id, multiplier, answer in
                            HStack {
                                Text("\(multipleOf) x \(multiplier) = \(answer)")
                                
                                let correct = checkAnswer(multiplier, answer)
                                Image(systemName: correct ? "checkmark": "xmark")
                                    .foregroundStyle(correct ? .green : .red)
                                    .scaleEffect(id == lastAddedMultiplierID ? scale: 1.0)
                                    .onAppear {
                                        
                                        if id == lastAddedMultiplierID {
                                            withAnimation(.smooth(duration: 0.2).delay(0.0)) {
                                                scale = 2.0
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                withAnimation(.easeInOut(duration: 0.5)) {
                                                    scale = 1.0
                                                }
                                            }
                                        }
                                    }
                            }
                        }
                    }
                    
                    if currentQuestionCount == numOfQuestionsSelections[selectedNumOfQuestions] {
                        Button("Done") {
                            inGamePlay = false
                        }
                    }
                } else {
                    VStack(alignment: .center) {
                        Stepper("Set the multiplication table: \(multipleOf)", value: $multipleOf, in: 2...12)
                        Stepper("Set the number of questions: \(numOfQuestionsSelections[selectedNumOfQuestions])", value: $selectedNumOfQuestions, in: 0...2)
                        Spacer()
                        Button("Start") {
                            inGamePlay = true
                            currentQuestionCount = 0
                            multipliers = []
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Multiplication Practice")
            .navigationBarTitleDisplayMode(.automatic)
            .animation(.bouncy, value: inGamePlay)
        }
    }
    
    fileprivate func resetQuestion() {
        multiplier = Int.random(in: 2...12)
        self.answer = ""
    }
    
    fileprivate func onSubmitAnswer(_ answer: String) {
        guard let storedAnswer = Int(answer) else { return }
        
        let newMultiplier = (id: UUID(), multiplier: multiplier, answer: storedAnswer)
        multipliers.insert(newMultiplier, at: 0)
        lastAddedMultiplierID = newMultiplier.id
        currentQuestionCount = currentQuestionCount + 1
        resetQuestion()
        isTextFieldFocused = true
    }
    
    fileprivate func checkAnswer(_ multiplier: Int, _ answer: Int) -> Bool {
        return answer == multiplier * multipleOf
    }
}

#Preview {
    ContentView()
}
