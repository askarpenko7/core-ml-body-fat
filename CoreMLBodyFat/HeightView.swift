//
//  HeightView.swift
//  CoreML Body Fat
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import SwiftUI

struct HeightView: View {
    @Binding var value: Double?
    var onTap: (MetricsField) -> Void
    private let markSpacing: CGFloat = 10

    var body: some View {
        VStack {
            MetricView(value: $value, field: .height, onTap: onTap)

            GeometryReader { geometry in
                let markCount = Int(geometry.size.height / markSpacing)

                Rectangle()
                    .fill(.clear)
                    .overlay(
                        VStack(spacing: 9) {
                            ForEach(0 ..< markCount, id: \.self) { id in
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: id % 5 == 0 ? 12 : 6, height: 1)
                            }
                        }
                    )
            }
        }
        .id(MetricsField.height)
    }
}

#Preview {
    VStack {
        HeightView(value: .constant(123.0), onTap: { _ in })
    }
    .frame(
        maxWidth: .infinity,
        maxHeight: .infinity,
        alignment: .bottom
    )
    .background(.bg)
}
