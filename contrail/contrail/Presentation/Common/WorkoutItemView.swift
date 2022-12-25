//
//  WorkoutItemView.swift
//  contrail
//
//  Created by tokizo on 2022/09/04.
//

import SwiftUI

struct WorkoutItem: Identifiable {
    enum WorkoutType: String {
        case cycling = "Cycling"
        case running = "Running"
        case walking = "Walking"
    }

    let type: WorkoutType
    let distanceString: String
    let dateString: String

    var id: String { distanceString + dateString }
}

struct WorkoutItemView: View {
    let item: WorkoutItem

    var workoutImageSystemName: String {
        switch item.type {
        case .cycling:
            return "bicycle.circle.fill"
        case .running:
            return "figure.run.circle.fill"
        case .walking:
            return "figure.walk.circle.fill"
        }
    }

    var foregroundColor: Color {
        switch item.type {
        case .cycling:
            return .blue
        case .running:
            return .green
        case .walking:
            return .yellow
        }
    }

    var body: some View {
        HStack(
            alignment: .center,
            spacing: 8
        ) {
            Image(systemName: workoutImageSystemName)
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
            HStack(alignment: .lastTextBaseline) {
                VStack(
                    alignment: .leading,
                    spacing: 2
                ) {
                    Text(item.type.rawValue)
                    HStack(
                        alignment: .lastTextBaseline,
                        spacing: 4
                    ) {
                        Text(item.distanceString)
                            .font(.title)
                        Text("KM")
                            .font(.title3)
                    }
                    .foregroundColor(foregroundColor)
                }
                Spacer()
                Text(item.dateString)
                    .font(.subheadline)
                    .foregroundColor(.lightGray)
                    .padding(.vertical, 5)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color.darkGray)
        .cornerRadius(10)
    }
}
