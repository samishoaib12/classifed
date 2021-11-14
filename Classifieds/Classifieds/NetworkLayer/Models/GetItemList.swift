//
//  GetSurveyModel.swift
//  NetworkLayer
//
import Foundation

public struct GetItemList: Codable {
    
    public var created_at: String
    public var price: String
    public var name: String
    public var uid: String
    public var image_urls: [String]
    public var image_urls_thumbnails: [String]
    public var image_ids: [String]
}
