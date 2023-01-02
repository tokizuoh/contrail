//
//  SummaryChartView.swift
//  contrail
//
//  Created by tokizo on 2022/09/03.
//

import Charts
import SwiftUI

struct SummaryChartViewItem {
    let totalDistanceString: String
    let workoutItems: [SummaryChartViewWorkoutItem]
}

struct SummaryChartViewWorkoutItem: Identifiable {
    enum WorkoutType: String {
        case cycling = "Cycling"
        case running = "Running"
        case walking = "Walking"
    }
    let type: WorkoutType
    let date: Date
    let distance: Double

    var id: Date { return date }
}

struct SummaryChartView: View {
    @State private var isPresentActivityView = false

    let data: SummaryChartViewItem

    var body: some View {
        ZStack(alignment: .topTrailing) {
            shareButton
            chartView
        }
        .padding(20)
        .background(Color.darkGray)
        .cornerRadius(10)
    }

    private var shareButton: some View {
        Button {
            isPresentActivityView = true
        } label: {
            Image(systemName: "square.and.arrow.up")
        }
        .sheet(isPresented: $isPresentActivityView) {
            ActivityView(
                activityItems: ["TODO"],
                applicationActivities: nil
            )
            .presentationDetents([.medium])
            .ignoresSafeArea(edges: [.bottom])
        }
    }

    private var chartView: some View {
        VStack(alignment: .leading) {
            VStack(
                alignment: .leading,
                spacing: 2
            ) {
                Text("Total Distances")
                    .font(.subheadline)
                    .foregroundColor(.lightGray1)
                Text("\(data.totalDistanceString) KM")
                    .font(.title2)
                    .bold()
            }
            Chart {
                ForEach(data.workoutItems) { item in
                    BarMark(
                        x: .value("Shape Type", item.date.formatted(.dateTime.month(.twoDigits))),
                        y: .value("Distance", item.distance)
                    )
                    .foregroundStyle(by: .value("Distance", item.type.rawValue))
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom) { _ in
                    AxisGridLine(centered: true)
                    AxisTick(centered: true)
                    AxisValueLabel()
                }
            }
            .chartForegroundStyleScale([
                SummaryChartViewWorkoutItem.WorkoutType.cycling.rawValue: .blue,
                SummaryChartViewWorkoutItem.WorkoutType.running.rawValue: .green,
                SummaryChartViewWorkoutItem.WorkoutType.walking.rawValue: .yellow
            ])
            .frame(height: 250)
        }
    }
}
