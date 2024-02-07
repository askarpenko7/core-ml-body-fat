//
//  ViewModel.swift
//  CoreML Body Fat
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import Foundation

final class ViewModel: ObservableObject {
    @Published var height: Double?
    @Published var age: Double?
    @Published var weight: Double?
    @Published var characterMetricsViewModel = CharacterMetricsViewModel()
    @Published var selectedGender: Gender = .female
    @Published var status = ""

    private var bodyFatModel = BodyFatModel()

    func updateMetric(for field: MetricsField?, with value: String?) {
        guard let field = field, let newValue = Double(value ?? "") else { return }
        switch field {
        case .height: height = newValue
        case .weight: weight = newValue
        case .age: age = newValue
        default:
            characterMetricsViewModel.updateMetric(for: field, with: newValue)
        }
        updateStatusText()
    }

    func findNextField() -> MetricsField? {
        if height == nil { return .height }
        if age == nil { return .age }
        if weight == nil { return .weight }
        return characterMetricsViewModel.findEmptyField()
    }

    func getValue(for field: MetricsField) -> String {
        switch field {
        case .height: return field.formatter.string(for: height) ?? ""
        case .weight: return field.formatter.string(for: weight) ?? ""
        case .age: return field.formatter.string(for: age) ?? ""
        default:
            let value = characterMetricsViewModel.getValue(for: field)
            return field.formatter.string(for: value) ?? ""
        }
    }

    func updateStatusText() {
        guard let nextField = findNextField() else {
            let input = createBodyFatPredictionInput()
            updateBodyFatPrediction(input)
            return
        }
        status = "Please enter your \(nextField.name.lowercased())."
    }

    private func createBodyFatPredictionInput() -> BodyFatPredictionInput {
        BodyFatPredictionInput(
            sex: selectedGender,
            age: Int64(age!),
            weight: weight!,
            height: height!,
            neck: characterMetricsViewModel.neck!,
            chest: characterMetricsViewModel.chest!,
            abdomen: characterMetricsViewModel.abdomen!,
            hip: characterMetricsViewModel.hip!,
            thigh: characterMetricsViewModel.thigh!,
            knee: characterMetricsViewModel.knee!,
            ankle: characterMetricsViewModel.ankle!,
            biceps: characterMetricsViewModel.biceps!,
            forearm: characterMetricsViewModel.forearm!,
            wrist: characterMetricsViewModel.wrist!
        )
    }

    private func updateBodyFatPrediction(_ input: BodyFatPredictionInput) {
        let result = bodyFatModel.makeAPrediction(input: input)
        switch result {
        case let .success(bodyFat):
            status = String(format: "Your body fat is %.2f%%", bodyFat)
        case .failure:
            status = "Prediction error. Please check your inputs."
        }
    }
}
