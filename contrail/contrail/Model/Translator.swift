//
//  Translator.swift
//  contrail
//
//  Created by tokizo on 2022/09/19.
//

protocol Translator {
    associatedtype From
    associatedtype To

    static func translate(_ from: From) -> To
}
