//
//  TopScreen.swift
//  contrail
//
//  Created by tokizo on 2022/08/11.
//

import SwiftUI

struct TopScreen: View {
    @ObservedObject var viewModel = TopViewModel(workoutsCacher: WorkoutsCacher.shared)

    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.data) { item in
                    TopWorkoutCell(item: item)
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("Abstract")
        .onAppear {
            viewModel.dispatch()
        }
    }
}

struct TopScreen_Previews: PreviewProvider {
    static var previews: some View {
        TopScreen()
    }
}

final class TopScreenHostingController: UIHostingController<TopScreen> {}

struct TopScreenBuilder {
    static func build() -> TopScreenHostingController {
        // swiftlint:disable identifier_name
        let vc = TopScreenHostingController(rootView: TopScreen())
        return vc
    }
}
