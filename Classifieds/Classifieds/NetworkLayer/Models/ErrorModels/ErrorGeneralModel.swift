//
//  ErrorGeneralModel.swift
//  NetworkLayer
//
import Foundation

public struct ErrorGeneralModel: Codable {
    public var code: Int
    public var message: String
    
    enum ErrorGeneralModelCodingKeys: String, CodingKey {
        case code = "code"
        case message = "message"
    }
    
    public init(from decoder: Decoder) throws {
        let modelContainer = try decoder.container(keyedBy: ErrorGeneralModelCodingKeys.self)
        code = try modelContainer.decode(Int.self, forKey: .code)
        message = try modelContainer.decode(String.self, forKey: .message)
    }
    
}

