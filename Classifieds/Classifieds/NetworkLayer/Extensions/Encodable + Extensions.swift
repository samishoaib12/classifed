//
//  Encodable + Extensions.swift
//  NetworkLayer
//
import Foundation

extension Encodable {
    
    public func toJSON() -> String? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted

        do {
            let jsonData = try jsonEncoder.encode(self)
            let json = String(data: jsonData, encoding: String.Encoding.utf8) ?? ""
            return json
        } catch {
            return nil
        }
    }
    
}
