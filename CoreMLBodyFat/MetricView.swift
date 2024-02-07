//
//  MetricView.swift
//  CoreML Body Fat
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import SwiftUI

struct MetricView: View, MetricDisplayable {
    @Binding var value: Double?
    var field: MetricsField
    var onTap: (MetricsField) -> Void

    private var displayValue: String {
        field.formatter.string(for: value) ?? ""
    }

    private var isEmptyValue: Bool {
        return value ?? -1 < 0.0
    }

    var body: some View {
        VStack(spacing: 4) {
            if !isEmptyValue {
                Text(displayValue)
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
                    .font(.title2)
            }

            Text(field.nameAndUnit)
                .foregroundStyle(.white)
                .fontWeight(.medium)
                .font(isEmptyValue ? .subheadline : .caption)
        }
        .padding(10)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white.opacity(0.8), lineWidth: 1.0)
        }
        .onTapGesture(perform: { onTap(field) })
    }
}

#Preview {
    VStack(content: {
        MetricView(value: .constant(183), field: .height, onTap: { _ in })

    })
    .frame(
        maxWidth: .infinity,
        maxHeight: .infinity
    )
    .background(.bg)
}
