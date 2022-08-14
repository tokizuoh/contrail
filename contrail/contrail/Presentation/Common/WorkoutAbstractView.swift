//
//  WorkoutAbstractView.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import SwiftUI

struct WorkoutAbstractViewItem: Identifiable {
    var id = UUID()
    let distanceText: String
    let dateText: String
}

struct WorkoutAbstractView: View {
    let item: WorkoutAbstractViewItem

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            HStack(alignment: .lastTextBaseline) {
                Text(item.distanceText)
                    .font(.title)
                Text("km")
                    .font(.subheadline)
            }
            .foregroundColor(.brand)
            .padding(.vertical, 10)

            Spacer()

            Text(item.dateText)
                .font(.subheadline)
                .foregroundColor(.lightGray)
                .padding(.vertical, 5)
        }
        .padding(.horizontal, 10)
        .background(Color.darkGray)
        .cornerRadius(10)
    }
}

struct WorkoutAbstractView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutAbstractView(
            item: .init(
                distanceText: "123.45",
                dateText: "2022.08.11"
            )
        )
    }
}
