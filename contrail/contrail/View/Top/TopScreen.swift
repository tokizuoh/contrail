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
            VStack(
                alignment: .leading,
                spacing: 20
            ) {
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    Text("Statistics")
                        .font(.title)
                        .bold()
                        .padding(.horizontal, 5)
                }
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    Text("Workout List")
                        .font(.title)
                        .bold()
                        .padding(.horizontal, 5)
                    LazyVStack(
                        alignment: .leading,
                        spacing: 5
                    ) {
                        ForEach(viewModel.data) { item in
                            TopWorkoutCell(item: item)
                        }
                    }

                }
            }
            .padding(.horizontal, 10)
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
