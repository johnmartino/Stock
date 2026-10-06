//
//  StockResponse.swift
//  stock
//
//  Created by John Martino on 10/6/26.
//

import Foundation

struct StockEntry: Decodable {
    let currency: String
    let regularMarketPrice: Double
    let chartPreviousClose: Double
}

struct StockResult: Decodable {
    let meta: StockEntry
}

struct Chart: Decodable {
    let result: [StockResult]
}

struct StockResponse: Decodable {
    let chart: Chart
}
