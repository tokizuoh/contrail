//
//  ChartView.swift
//  contrail
//
//  Created by tokizo on 2023/01/02.
//

import Charts
import SwiftUI

struct ChartItem: Identifiable {
    let date: Date
    let quantity: Double
    var id: Date { date }
}

struct ChartView: View {
    let items: [ChartItem]

    var body: some View {
        Chart(items) { item in
            BarMark(
                x: .value("Day", item.date, unit: .day),
                y: .value("Quantity", item.quantity)
            )
        }
        .foregroundColor(.healthRed)
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday())
            }
        }
    }
}

#if DEBUG
struct ChartView_Previews: PreviewProvider {
    static private var chartItems: [ChartItem] = [
        .init(
            date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!,
            quantity: 30.0
        ),
        .init(
            date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
            quantity: 120.0
        ),
        .init(
            date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!,
            quantity: 100.0
        ),
        .init(
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
            quantity: 10.0
        ),
        .init(
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
            quantity: 176.0
        ),
        .init(
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            quantity: 100.0
        ),
        .init(
            date: Date(),
            quantity: 40.0
        )
    ]

    static var previews: some View {
        ChartView(items: chartItems)
    }
}
#endif
