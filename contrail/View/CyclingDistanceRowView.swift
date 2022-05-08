//
//  CyclingDistanceRowView.swift
//  contrail
//
//  Created by tokizo on 2022/05/08.
//

import SwiftUI

struct CyclingDistanceRowView: View {
    let cyclingDistance: CyclingDistance
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text("\(cyclingDistance.distance.description) km")
                .font(.title)
                .padding(EdgeInsets(top: 5,
                                    leading: 20,
                                    bottom: 5,
                                    trailing: 0))
            Spacer()
            Text(cyclingDistance.date)
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

struct CyclingDistanceRowView_Previews: PreviewProvider {
    static var previews: some View {
        CyclingDistanceRowView(cyclingDistance: .init(distance: 41.456,
                                                      date: "2022.05.08"))
    }
}
