//
//  BodyFatModel.swift
//  CoreML Body Fat
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import CoreML
import Foundation

struct BodyFatPredictionInput {
    var sex: Gender
    var age: Int64
    var weight: Double
    var height: Double
    var neck: Double
    var chest: Double
    var abdomen: Double
    var hip: Double
    var thigh: Double
    var knee: Double
    var ankle: Double
    var biceps: Double
    var forearm: Double
    var wrist: Double
}

final class BodyFatModel {
    func makeAPrediction(input: BodyFatPredictionInput) -> Result<Double, Error> {
        guard let model = initializeModel() else {
            return .failure(ModelInitializationError())
        }

        do {
            let prediction = try model.prediction(
                Sex: input.sex.abbreviation,
                Age: input.age,
                Weight: input.weight,
                Height: input.height / 100,
                Neck: input.neck,
                Chest: input.chest,
                Abdomen: input.abdomen,
                Hip: input.hip,
                Thigh: input.thigh,
                Knee: input.knee,
                Ankle: input.ankle,
                Biceps: input.biceps,
                Forearm: input.forearm,
                Wrist: input.wrist
            )
            return .success(prediction.BodyFat)
        } catch {
            return .failure(error)
        }
    }

    private func initializeModel() -> BodyFatModelExtended? {
        let configuration = MLModelConfiguration()
        guard let model = try? BodyFatModelExtended(configuration: configuration) else {
            print("Failed to initialize the BodyFatModelExtended")
            return nil
        }
        return model
    }
}

struct ModelInitializationError: Error {
    // TODO: Implement
}
