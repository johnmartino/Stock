//
//  StockService.swift
//  stock
//
//  Created by John Martino on 10/6/26.
//

import Foundation

// https://query1.finance.yahoo.com/v8/finance/chart/AAPL?range=5d&interval=1d

class StockService {
    func lookup(_ code: String) async throws -> StockEntry {
        guard let url = URL(string: "https://query1.finance.yahoo.com/v8/finance/chart/\(code.trimmingCharacters(in: .whitespacesAndNewlines))?range=1d&interval=1d") else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(StockResponse.self, from: data)
        if let meta = response.chart.result.first?.meta {
            return StockEntry(currency: meta.currency, regularMarketPrice: meta.regularMarketPrice, chartPreviousClose: meta.chartPreviousClose)
        } else {
            throw URLError(.cannotDecodeRawData)
        }
    }
}
