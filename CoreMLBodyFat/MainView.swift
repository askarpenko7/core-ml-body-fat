//
//  MainView.swift
//  CoreML Body Fat
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var focusedField: MetricsField?
    @State private var inputText = ""
    @FocusState private var isInputFocused: Bool

    @State private var showFloatingInput = false {
        didSet {
            isInputFocused = showFloatingInput
        }
    }

    @State private var scrollPosition: ScrollPosition?

    private let animationDuration = 0.3

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 6, pinnedViews: [.sectionFooters]) {
                Section {
                    VStack {
                        topView

                        characterView

                        weightView
                    }
                    .overlay {
                        VStack {
                            Color.clear.id(ScrollPosition.top)
                            Color.clear.id(ScrollPosition.aboveCenter)
                            Color.clear.id(ScrollPosition.center)
                            Color.clear.id(ScrollPosition.belowCenter)
                            Color.clear.id(ScrollPosition.bottom)
                        }
                    }
                } footer: {
                    if showFloatingInput {
                        inputView
                    }
                }
            }
        }
        .scrollDisabled(!showFloatingInput)
        .scrollPosition(id: $scrollPosition, anchor: .center)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, .light)
        .background(
            backgroundView
        )
        .onAppear(perform: viewModel.updateStatusText)
        .onChange(of: viewModel.selectedGender, initial: true) { _, _ in
            withAnimation {
                viewModel.characterMetricsViewModel.updateGender(viewModel.selectedGender)
                viewModel.updateStatusText()
            }
        }
    }

    @ViewBuilder
    private var topView: some View {
        Text($viewModel.status.wrappedValue)
            .foregroundStyle(.white)
            .font(.title)

        Picker("Gender", selection: $viewModel.selectedGender) {
            ForEach(Gender.allCases) { gender in
                Text(gender.title)
            }
        }
        .pickerStyle(.segmented)
        .padding(.vertical, 3)
        .padding(.horizontal, 3)
        .frame(width: 150)
        .background(RoundedRectangle(cornerRadius: 10).fill(.bg))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 1) // Custom border
        )
        .onAppear(perform: {
            UISegmentedControl.appearance().setTitleTextAttributes(
                [.foregroundColor: UIColor.bg],
                for: .selected
            )
            UISegmentedControl.appearance().setTitleTextAttributes(
                [.foregroundColor: UIColor.white],
                for: .normal
            )
        })
    }

    @ViewBuilder
    private var characterView: some View {
        CharacterView(viewModel: viewModel.characterMetricsViewModel) { field in
            triggerInput(for: field)
        }
        .padding(.horizontal, 90)
        .frame(maxHeight: 500)
        .overlay {
            ZStack(alignment: .top) {
                HeightView(value: $viewModel.height) { field in
                    triggerInput(for: field)
                }
                .offset(x: -135)

                MetricView(value: $viewModel.age, field: .age) { field in
                    triggerInput(for: field)
                }
                .offset(x: 135)
            }
        }
        .onTapGesture(perform: dismissInput)
    }

    @ViewBuilder
    private var weightView: some View {
        WeightView(value: $viewModel.weight) { field in
            triggerInput(for: field)
        }
        .padding(.top, 6)
        .padding(.bottom, 40)
    }

    @ViewBuilder
    private var backgroundView: some View {
        Rectangle()
            .fill(LinearGradient(
                gradient: Gradient(colors: [.bg, .gradientDark, .gradientLight]),
                startPoint: .top,
                endPoint: .bottom
            ))
            .edgesIgnoringSafeArea(.all)
    }

    @ViewBuilder
    private var inputView: some View {
        FloatingInputView(
            isFocused: _isInputFocused,
            focusedField: $focusedField,
            inputText: $inputText,
            onSubmit: handleSubmission
        )
        .fixedSize(horizontal: false, vertical: true)
    }

    private func triggerInput(for field: MetricsField) {
        withAnimation(.easeInOut(duration: animationDuration)) {
            showFloatingInput = true
            focusedField = field
            inputText = viewModel.getValue(for: field)

            switch field {
            case .height, .age: scrollPosition = .top
            case .neck, .chest, .biceps: scrollPosition = .aboveCenter
            case .abdomen, .forearm, .wrist, .hip: scrollPosition = .center
            case .thigh, .knee: scrollPosition = .belowCenter
            case .weight, .ankle: scrollPosition = .bottom
            }
        }
    }

    private func dismissInput() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            showFloatingInput = false
            focusedField = nil
            scrollPosition = .top
        }
    }

    private func handleSubmission() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            viewModel.updateMetric(for: focusedField, with: inputText)
            inputText = ""
        }
        if let focusedField = viewModel.findNextField() {
            triggerInput(for: focusedField)
        } else {
            dismissInput()
        }
    }
}

private enum ScrollPosition: Hashable {
    case top
    case aboveCenter
    case center
    case belowCenter
    case bottom
}

#Preview {
    MainView()
}
