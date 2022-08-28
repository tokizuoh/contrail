//
//  AnalyticsScreen.swift
//  contrail
//
//  Created by tokizo on 2022/08/28.
//

import SwiftUI

struct AnalyticsScreen: View {
    var body: some View {
        ScrollView {
            LazyVStack(
                alignment: .leading
            ) {
                AnalyticsChartView()
                // TODO: ボタン: 何かしらのAverage
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
        }
        .navigationTitle("Analytics")
    }
}

struct AnalyticsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsScreen()
    }
}
