//
//  WeightView.swift
//  CoreML Body Fat
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import SwiftUI

struct WeightView: View {
    @Binding var value: Double?
    var onTap: (MetricsField) -> Void

    private let marksCount = 12
    private var isEmptyValue: Bool {
        value != nil
    }

    var body: some View {
        VStack(spacing: 5, content: {
            MetricView(value: $value, field: .weight, onTap: onTap)

            HStack(spacing: 10, content: {
                ForEach(0 ... marksCount, id: \.self) { index in
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 1, height: calculateMarkHeight(for: index))
                }
            })
        })
        .id(MetricsField.weight)
    }

    private func calculateMarkHeight(for index: Int) -> CGFloat {
        index == marksCount / 2 ? 30 : index % 3 == 0 ? 16 : 8
    }
}

#Preview {
    VStack {
        WeightView(value: .constant(121.3), onTap: { _ in })
            .padding(.horizontal, 40)
    }
    .frame(
        maxWidth: .infinity,
        maxHeight: .infinity
    )
    .background(.bg)
}
