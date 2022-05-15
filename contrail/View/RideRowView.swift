//
//  RideRowView.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import SwiftUI

struct RideRowView: View {
    let ride: Ride

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            HStack(alignment: .lastTextBaseline) {
                Text(ride.distanceText)
                    .font(.title)
                    .padding(.leading, 20)
                Text("km")
                    .font(.subheadline)
            }
            .padding(.vertical, 5)

            Spacer()

            Text(ride.dateText)
                .font(.subheadline)
                .foregroundColor(.contrailDarkGray)
                .padding(EdgeInsets(top: 5,
                                    leading: 0,
                                    bottom: 5,
                                    trailing: 20))
        }
        .background(.white)
        .cornerRadius(8)
    }
}

struct Ride: ViewModelProtocol, Identifiable {
    var id = UUID()

    let distanceText: String
    let dateText: String

    static func generateEmpty() -> Ride {
        return .init(distanceText: "",
                     dateText: "")
    }

    static func generateMock() -> Ride {
        return .init(distanceText: "12.3",
                     dateText: "2222.11.3")
    }
}

struct RideRowView_Previews: PreviewProvider {
    static var previews: some View {
        RideRowView(ride: .generateMock())
    }
}