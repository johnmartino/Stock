# Stock Project Guide

## Overview

Stock is a Swift command-line tool for looking up a stock quote and comparing its performance with an earlier value.

## Architecture

- `StockMain.swift` defines the asynchronous ArgumentParser command-line interface.
- `StockService.swift` owns remote quote retrieval and response decoding.
- `StockResponse.swift` contains the `Decodable` transport models.

Keep command parsing, networking, and response models separate. Pass dependencies into services when adding behavior that needs isolated tests.

## Conventions

- Follow modern Swift naming and API design conventions.
- Prefer structured concurrency with `async`/`await`.
- Model remote payloads with `Decodable` types and avoid force unwrapping.
- Keep changes scoped to the requested behavior.

## Build and Run

Build the active `stock` scheme in Xcode. Run the executable with a stock symbol argument; `lookup` is the default subcommand and `l` is its alias.

## Gotchas

- JSON decoding requires the complete nested model graph to conform to `Decodable`.
- Yahoo Finance response fields may be numeric or nullable, so models must match the actual payload before decoded values are consumed.
