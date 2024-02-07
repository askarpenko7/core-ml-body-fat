//
//  Gender.swift
//  CoreML Body Fat
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import Foundation

enum Gender: Hashable, CaseIterable, Identifiable {
    case female
    case male

    var id: Self {
        return self
    }

    var abbreviation: String {
        switch self {
        case .male:
            return "M"
        case .female:
            return "F"
        }
    }

    var title: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}
