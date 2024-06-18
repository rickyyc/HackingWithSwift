//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by ricky on 2024-06-06.
//

import SwiftUI

struct Question: Identifiable {
    var multiplicand: Int
    var multiplier: Int
    var answer: Int? = nil
    var id: UUID
}

struct ContentView: View {
    @State private var inGamePlay = false
    @State private var selectedNumOfQuestions = 0
    @State private var currentQuestionCount = 0
    @State private var questions: [Question] = []
    
    // used for checkmark and xmark animations
    @State private var scale = 1.0
    @State private var lastAnsweredQuestionID: UUID?
    
    @State private var multiplicand = 2
    @State private var answer = ""
    @FocusState private var isTextFieldFocused: Bool
    
    private let numOfQuestionsSelections = [5, 10, 20]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                if inGamePlay {
                    if currentQuestionCount < questions.count {
                        let currentQuestion = questions[currentQuestionCount]
                        HStack {
                            Text("\(currentQuestion.multiplicand) x \(currentQuestion.multiplier) = ")
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
                                .onSubmit() {
                                    onSubmitAnswer(answer)
                                }
                        }
                    }
                    List {
                        ForEach(questions.reversed()) { question in
                            if let answer = question.answer {
                                HStack {
                                    Text("\(question.multiplicand) x \(question.multiplier) = \(answer)")
                                    
                                    let correct = question.multiplicand * question.multiplier == answer
                                    Image(systemName: correct ? "checkmark": "xmark")
                                        .foregroundStyle(correct ? .green : .red)
                                        .scaleEffect(question.id == lastAnsweredQuestionID ? scale: 1.0)
                                        .onAppear {
                                            if question.id == lastAnsweredQuestionID {
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
                    }
                    
                    if currentQuestionCount == numOfQuestionsSelections[selectedNumOfQuestions] {
                        Button("Done") {
                            inGamePlay = false
                        }
                    }
                } else {
                    VStack(alignment: .center) {
                        Stepper("Set the multiplication table: \(multiplicand)", value: $multiplicand, in: 2...12)
                        Stepper("Set the number of questions: \(numOfQuestionsSelections[selectedNumOfQuestions])", value: $selectedNumOfQuestions, in: 0...2)
                        Spacer()
                        Button("Start") {
                            onStart()
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Multiplication Practice")
            .navigationBarTitleDisplayMode(.automatic)
            .animation(.default, value: inGamePlay)
        }
    }
    
    fileprivate func onStart() {
        // generate and populate the questions
        let num = numOfQuestionsSelections[selectedNumOfQuestions]
        
        questions.removeAll(keepingCapacity: true)
        
        for _ in 1...num {
            let multiplier = Int.random(in: 2...12)
            questions.append(
                Question(multiplicand: multiplicand, multiplier: multiplier, answer: nil, id: UUID())
            )
        }
        
        inGamePlay = true
        currentQuestionCount = 0
    }
    
    fileprivate func onSubmitAnswer(_ input: String) {
        guard let storedAnswer = Int(input) else { return }
        
        questions[currentQuestionCount].answer = storedAnswer
        // update the last updated id
        lastAnsweredQuestionID = questions[currentQuestionCount].id
        currentQuestionCount = currentQuestionCount + 1
        isTextFieldFocused = true
        answer = ""
    }
}

#Preview {
    ContentView()
}
