//
//  MarkerMetricView.swift
//  CoreML Body Fat
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import SwiftUI

struct MarkerMetricView: View, MetricDisplayable {
    @Binding var value: Double?
    var field: MetricsField

    var onTap: (MetricsField) -> Void

    private var isFilled: Bool {
        return value != nil && value ?? -1 > 0
    }

    private var displayValue: String {
        field.formatter.string(for: value) ?? ""
    }

    private var pulsateAnimation: Animation {
        Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true)
    }

    @State private var pulsate = false

    @State private var hOffset = 0.0

    var body: some View {
        ZStack(alignment: .center) {
            if isFilled {
                filledView
            } else {
                emptyView
            }
        }
        .offset(x: hOffset)
        .onTapGesture(perform: { onTap(field) })
        .onAppear {
            self.pulsate = !self.isFilled
        }
        .onChange(of: isFilled) { _, newValue in
            self.pulsate = !newValue
        }
    }

    @ViewBuilder
    private var filledView: some View {
        HStack(spacing: 8) {
            dotView
                .padding(.leading, 3)

            Text(displayValue)
                .font(.footnote)
                .padding(.trailing, 8)
                .foregroundStyle(.white)
        }
        .frame(height: 30)
        .background {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(.black.opacity(0.2))
        }
        .overlay(
            GeometryReader { geometry in
                Color.clear
                    .onChange(of: value, initial: true) { updateOffset(for: geometry.size) }
            }
        )
    }

    @ViewBuilder
    private var emptyView: some View {
        dotView
            .onChange(of: value, initial: true) { updateOffset(for: .zero) }
    }

    @ViewBuilder
    private var dotView: some View {
        ZStack {
            Circle()
                .fill(isFilled ? .accent : .emptyMarker)
                .frame(width: 25, height: 25)
                .scaleEffect(pulsate ? 2 : 1)
                .opacity(pulsate ? 0.8 : 1)
                .animation(pulsate ? pulsateAnimation : .default, value: pulsate)

            Circle()
                .fill(Color.white)
                .frame(width: 10, height: 10)
                .scaleEffect(pulsate ? 1.5 : 1)
        }
    }

    private func updateOffset(for size: CGSize) {
        withAnimation {
            hOffset = isFilled ? ((size.width / 2) - 15.5) : 0
        }
    }
}

#Preview {
    VStack(spacing: 10, content: {
        MarkerMetricView(value: .constant(0), field: .chest, onTap: { field in
            print(field)
        })

        MarkerMetricView(value: .constant(1), field: .chest, onTap: { field in
            print(field)
        })

        MarkerMetricView(value: .constant(12), field: .chest, onTap: { field in
            print(field)
        })

        MarkerMetricView(value: .constant(123), field: .chest, onTap: { field in
            print(field)
        })

        MarkerMetricView(value: .constant(123.4), field: .chest, onTap: { field in
            print(field)
        })

        MarkerMetricView(value: .constant(123.45), field: .chest, onTap: { field in
            print(field)
        })
    })
    .frame(
        maxWidth: .infinity,
        maxHeight: .infinity
    )
    .background(.bg)
}

