//
//  MainWorkoutCell.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import SwiftUI

struct MainWorkoutCellItem: Identifiable {
    var id = UUID()
    let distanceText: String
    let dateText: String
}

struct MainWorkoutCell: View {
    let item: MainWorkoutCellItem

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            HStack(alignment: .lastTextBaseline) {
                Text(item.distanceText)
                    .font(.title)
                Text("km")
                    .font(.subheadline)
            }
            //            .foregroundColor(.contrailBrand1)
            .padding(.vertical, 5)

            Spacer()

            Text(item.dateText)
                .font(.subheadline)
                //                .foregroundColor(.contrailLightGray2)
                .padding(.vertical, 5)
        }
    }
}

struct MainWorkoutCell_Previews: PreviewProvider {
    static var previews: some View {
        MainWorkoutCell(
            item: .init(
                distanceText: "123.45",
                dateText: "2022.08.11"
            )
        )
    }
}
