import Foundation
import ArgumentParser

@main
struct Stock: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A tool for looking up a stock quote",
        discussion: "This tool is used to quickly lookup a stock and see how it's performing relative to a past date",
        subcommands: [Lookup.self],
        defaultSubcommand: Lookup.self
    )
    
    struct Lookup: AsyncParsableCommand {
        static let configuration = CommandConfiguration(aliases: ["l"])
        
        @Argument(help: "The stock symbol")
        var symbol: String
        
        func run() async throws {
            let service = StockService()
            let result = try await service.lookup(symbol)
            
            let change = result.regularMarketPrice - result.chartPreviousClose
            let indicator = change > 0 ? "\u{001B}[32m▲\u{001B}[0m" : change < 0 ? "\u{001B}[31m▼\u{001B}[0m" : "—"
            let currencyStyle = FloatingPointFormatStyle<Double>.Currency(code: result.currency)
                .precision(.fractionLength(2))
            print("\(symbol.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)) \(indicator) \(result.regularMarketPrice.formatted(currencyStyle)) (\(change.formatted(currencyStyle)))")
        }
    }
}
