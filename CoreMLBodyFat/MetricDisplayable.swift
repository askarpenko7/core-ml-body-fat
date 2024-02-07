//
//  MetricDisplayable.swift
//  CoreML Body Fat
//
//  Created by Alexander Karpenko on 07.02.2024.
//

import Foundation

protocol MetricDisplayable {
    var field: MetricsField { get }
    var onTap: (MetricsField) -> Void { get }
}
