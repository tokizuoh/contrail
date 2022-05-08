//
//  CyclingDistanceRowView.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import SwiftUI

struct CyclingDistanceRowView: View {
    let distance: Double
    let date: String

    var body: some View {
        HStack(alignment: .bottom) {
            Text("\(distance.description) km")
                .font(.title)
                .padding(EdgeInsets(top: 0,
                                    leading: 20,
                                    bottom: 0,
                                    trailing: 0))
            Spacer()
            Text(date)
                .font(.subheadline)
                .padding(EdgeInsets(top: 0,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 20))
        }
    }
}

struct CyclingDistanceRowView_Previews: PreviewProvider {
    static var previews: some View {
        CyclingDistanceRowView(distance: 41.456,
                               date: "2022.05.08")
    }
}
