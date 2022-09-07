//
//  CoffeeMethods.swift
//  CoffeeBee
//
//  Created by Agata Menes on 29/08/2022.
//

import Foundation
 
struct CoffeeMethods {
    let name: String
    let waterRatio: Int
    let grindSize:String
    let time: Double
    let temperatureInC: Int
}
struct MethodList: Codable {
    let methods: [Method]
}

// MARK: - Method
struct Method: Codable {
    let name: String
    let desc: String
    let steps: [Step]
}

// MARK: - Step
struct Step: Codable {
    let timer: Int?
    let step: String
}

