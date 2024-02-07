//
//  CharacterMetricsViewModel.swift
//  CoreML Body Fat
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import Foundation

final class CharacterMetricsViewModel: ObservableObject {
    @Published var gender: Gender = .female
    @Published var neck: Double?
    @Published var chest: Double?
    @Published var abdomen: Double?
    @Published var biceps: Double?
    @Published var forearm: Double?
    @Published var wrist: Double?
    @Published var hip: Double?
    @Published var thigh: Double?
    @Published var knee: Double?
    @Published var ankle: Double?

    var originalViewSize: CGSize {
        switch gender {
        case .female: return CGSize(width: 255.2, height: 759)
        case .male: return CGSize(width: 313.97, height: 759)
        }
    }

    func updateGender(_ gender: Gender) {
        self.gender = gender
    }

    func updateMetric(for field: MetricsField, with value: Double) {
        switch field {
        case .neck: neck = value
        case .chest: chest = value
        case .abdomen: abdomen = value
        case .biceps: biceps = value
        case .forearm: forearm = value
        case .wrist: wrist = value
        case .hip: hip = value
        case .thigh: thigh = value
        case .knee: knee = value
        case .ankle: ankle = value
        default: break
        }
    }

    func getValue(for field: MetricsField) -> Double? {
        switch field {
        case .neck: neck
        case .chest: chest
        case .abdomen: abdomen
        case .biceps: biceps
        case .forearm: forearm
        case .wrist: wrist
        case .hip: hip
        case .thigh: thigh
        case .knee: knee
        case .ankle: ankle
        default: nil
        }
    }

    func findEmptyFields() -> [MetricsField] {
        var result = [MetricsField]()
        if neck == nil { result.append(.neck) }
        if chest == nil { result.append(.chest) }
        if abdomen == nil { result.append(.abdomen) }
        if biceps == nil { result.append(.biceps) }
        if forearm == nil { result.append(.forearm) }
        if wrist == nil { result.append(.wrist) }
        if hip == nil { result.append(.hip) }
        if thigh == nil { result.append(.thigh) }
        if knee == nil { result.append(.knee) }
        if ankle == nil { result.append(.ankle) }
        return result
    }

    func findEmptyField() -> MetricsField? {
        return findEmptyFields().first
    }

    func getMarkerPoints(for size: CGSize) -> [MetricsField: CGPoint] {
        let scaleW = size.width / originalViewSize.width // Scale factor for width
        let scaleH = size.height / originalViewSize.height // Scale factor for height
        switch gender {
        case .female: return [
                .neck: CGPoint(x: 144 * scaleW, y: 130 * scaleH),
                .chest: CGPoint(x: 125 * scaleW, y: 198 * scaleH),
                .abdomen: CGPoint(x: 139 * scaleW, y: 297 * scaleH),
                .biceps: CGPoint(x: 225 * scaleW, y: 245 * scaleH),
                .forearm: CGPoint(x: 62 * scaleW, y: 320 * scaleH),
                .wrist: CGPoint(x: 53 * scaleW, y: 395 * scaleH),
                .hip: CGPoint(x: 220 * scaleW, y: 360 * scaleH),
                .thigh: CGPoint(x: 195 * scaleW, y: 465 * scaleH),
                .knee: CGPoint(x: 55 * scaleW, y: 548 * scaleH),
                .ankle: CGPoint(x: 70 * scaleW, y: 705 * scaleH),
            ]
        case .male: return [
                .neck: CGPoint(x: 151 * scaleW, y: 110 * scaleH),
                .chest: CGPoint(x: 135 * scaleW, y: 185 * scaleH),
                .abdomen: CGPoint(x: 135 * scaleW, y: 320 * scaleH),
                .biceps: CGPoint(x: 265 * scaleW, y: 215 * scaleH),
                .forearm: CGPoint(x: 56 * scaleW, y: 293 * scaleH),
                .wrist: CGPoint(x: 243 * scaleW, y: 348 * scaleH),
                .hip: CGPoint(x: 90 * scaleW, y: 390 * scaleH),
                .thigh: CGPoint(x: 200 * scaleW, y: 460 * scaleH),
                .knee: CGPoint(x: 208 * scaleW, y: 545 * scaleH),
                .ankle: CGPoint(x: 80 * scaleW, y: 700 * scaleH),
            ]
        }
    }
}
