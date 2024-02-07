//
//  CharacterView.swift
//  CoreML Body Fat
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import SwiftUI

struct CharacterView: View {
    @StateObject var viewModel: CharacterMetricsViewModel
    var onTap: (MetricsField) -> Void
    var body: some View {
        
        let characterImage = viewModel.gender == .female ? Image(.female) : Image(.male)

        characterImage
            .resizable()
            .scaledToFit()
            .shadow(radius: 10, x: 1, y: 1)
            .overlay {
                GeometryReader { geometry in
                    markerMetricViews(for: geometry.size)
                }
            }
    }

    private func markerMetricViews(for size: CGSize) -> some View {
        let scaleFactor = min(
            size.width / viewModel.originalViewSize.width,
            size.height / viewModel.originalViewSize.height
        )

        return Group {
            ForEach(MetricsField.characterCases) { field in
                let value = viewModel.getValue(for: field)
                let positions = viewModel.getMarkerPoints(for: size)
                MarkerMetricView(value: Binding.constant(value), field: field, onTap: onTap)
                    .scaleEffect(scaleFactor)
                    .position(positions[field] ?? .zero)
            }
        }
    }
}

#Preview {
    CharacterView(viewModel: CharacterMetricsViewModel()) { _ in
    }
}

