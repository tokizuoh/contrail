//
//  ContrailAPI.swift
//  contrail
//
//  Created by tokizo on 2022/08/13.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()

    private init() {}

    private(set) lazy var apollo = ApolloClient(url: URL(string: "http://192.168.3.3:8080/query")!)
}
