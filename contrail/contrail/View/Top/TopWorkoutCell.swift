//
//  TopWorkoutCell.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import SwiftUI

struct TopWorkoutCellItem: Identifiable {
    var id = UUID()
    let distanceText: String
    let dateText: String
}

struct TopWorkoutCell: View {
    let item: TopWorkoutCellItem

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            HStack(alignment: .lastTextBaseline) {
                Text(item.distanceText)
                    .font(.title)
                Text("km")
                    .font(.subheadline)
            }
            .foregroundColor(.brand)
            .padding(.vertical, 5)

            Spacer()

            Text(item.dateText)
                .font(.subheadline)
                .foregroundColor(.lightGray)
                .padding(.vertical, 5)
        }
    }
}

struct MainWorkoutCell_Previews: PreviewProvider {
    static var previews: some View {
        TopWorkoutCell(
            item: .init(
                distanceText: "123.45",
                dateText: "2022.08.11"
            )
        )
    }
}
