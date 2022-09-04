//
//  WorkoutItemView.swift
//  contrail
//
//  Created by tokizo on 2022/09/04.
//

import SwiftUI

struct WorkoutItem {
    enum WorkoutType: String {
        case cycling = "Cycling"
        case running = "Running"
    }

    let type: WorkoutType
    let distanceString: String
    let dateString: String

}

struct WorkoutItemView: View {
    let item: WorkoutItem

    var workoutImageSystemName: String {
        switch item.type {
        case .cycling:
            return "bicycle.circle.fill"
        case .running:
            return "figure.run.circle.fill"
        }
    }

    var body: some View {
        HStack(alignment: .bottom) {
            Image(systemName: workoutImageSystemName)
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                Text(item.type.rawValue)
                (
                    Text(item.distanceString)
                        .font(.title) +
                        Text("km")
                        .font(.subheadline)
                )
                .foregroundColor(.brand)
            }
            Spacer()
            Text(item.dateString)
                .font(.subheadline)
                .foregroundColor(.darkGray)
                .padding(.vertical, 5)
        }
    }
}
