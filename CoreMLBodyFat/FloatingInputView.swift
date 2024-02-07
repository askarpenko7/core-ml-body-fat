//
//  FloatingInputView.swift
//  CoreML Body Fat
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import SwiftUI

struct FloatingInputView: View {
    @FocusState var isFocused: Bool
    @Binding var focusedField: MetricsField?
    @Binding var inputText: String
    var onSubmit: () -> Void

    @State private var keyboardHeight: CGFloat = 0
    @State private var isInputValid = true

    private var placeholderText: String {
        focusedField?.nameAndUnit ?? "Enter Value"
    }

    private var instructionText: String {
        focusedField?.instruction ?? "¯\\_(ツ)_/¯"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(instructionText)
                .font(.title3)

            HStack(spacing: 16) {
                TextField(placeholderText, text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isFocused)
                    .background(Color.white)
                    .keyboardType(.decimalPad)
                    .onChange(of: inputText) { _, newValue in
                        isInputValid = isValidInput(newValue, for: focusedField)
                    }

                Button("Submit") {
                    onSubmit()
                }
                .disabled(!isInputValid)
                .foregroundStyle(isInputValid ? .accent : .gray)
            }

            if !isInputValid {
                Text("Invalid input")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .onDisappear {
            focusedField = nil
            resetInput()
        }
        .onChange(of: focusedField, initial: true) { _, _ in
            resetInput()
        }
    }

    private func isValidInput(_ input: String, for field: MetricsField?) -> Bool {
        guard let field = field else { return false }
        switch field {
        case .age:
            let input = Int(input)
            return input != nil && input ?? 0 > 17 && input ?? 0 < 100
        default:
            let input = Double(input)
            return input != nil && input ?? 0 > 0 && input ?? 0 < 1000
        }
    }

    private func resetInput() {
        isInputValid = true
    }
}

#Preview {
    VStack(content: {
        Spacer()
        FloatingInputView(focusedField: .constant(.biceps), inputText: .constant("")) {}
    })
    .background(.bg)
}

