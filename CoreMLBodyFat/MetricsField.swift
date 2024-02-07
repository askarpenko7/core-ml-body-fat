//
//  MetricsField.swift
//  CoreML Body Fat
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import Foundation

enum MetricsField: Hashable, Identifiable {
    case height
    case weight
    case age
    case neck
    case chest
    case abdomen
    case biceps
    case forearm
    case wrist
    case hip
    case thigh
    case knee
    case ankle

    var id: Self {
        return self
    }

    static var characterCases: [MetricsField] {
        [
            .neck,
            .chest,
            .abdomen,
            .biceps,
            .forearm,
            .wrist,
            .hip,
            .thigh,
            .knee,
            .ankle,
        ]
    }

    var name: String {
        switch self {
        case .weight: "Weight"
        case .height: "Height"
        case .age: "Age"
        case .neck: "Neck"
        case .chest: "Chest"
        case .abdomen: "Abdomen"
        case .biceps: "Biceps"
        case .forearm: "Forearm"
        case .wrist: "Wrist"
        case .hip: "Hip"
        case .thigh: "Thigh"
        case .knee: "Knee"
        case .ankle: "Ankle"
        }
    }

    var nameAndUnit: String {
        switch self {
        case .weight: "\(name), kg"
        case .age: "\(name), years"
        default: "\(name), cm"
        }
    }

    var instruction: String {
        switch self {
        case .height: "📏 Enter your height. Stand straight against a wall, mark the top of your head, and measure."
        case .weight: "⚖️ Enter your weight in kilograms. Use a reliable scale on a flat surface."
        case .age: "🎂 Enter your current age in full years."
        case .neck: "👔 Measure around your neck at its widest point, usually just above the Adam's apple."
        case .chest: "🏋️ Wrap the tape around the widest part of your chest, under your armpits and around your shoulder blades."
        case .abdomen: "🧍 Measure around your abdomen at the level of your belly button (navel)."
        case .biceps: "💪 Measure around the largest part of your bicep with the muscle lightly flexed."
        case .forearm: "🤲 Measure around the fullest part of the forearm."
        case .wrist: "🖐️ Measure around your wrist, just below the wrist bone."
        case .hip: "🧘 Measure around the widest part of your hips and buttocks."
        case .thigh: "🦵 Measure around the thickest part of your thigh."
        case .knee: "🦵 Measure around your knee at its widest point."
        case .ankle: "🦶 Measure around the ankle at its narrowest point."
        }
    }

    var formatter: Formatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        switch self {
        case .age:
            formatter.allowsFloats = false
            formatter.minimumIntegerDigits = 2
            formatter.maximumIntegerDigits = 3
            formatter.maximum = 99
            formatter.minimum = 18
        default:
            formatter.allowsFloats = true
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            formatter.minimumIntegerDigits = 1
            formatter.maximumIntegerDigits = 3
            formatter.minimum = 9
            formatter.maximum = 999
        }
        return formatter
    }
}
