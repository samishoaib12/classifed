//
//  String + Extensions.swift
//  NetworkLayer
//
import Foundation

extension String {
    
    static let windows1256 = String.Encoding(rawValue:
              CFStringConvertEncodingToNSStringEncoding(
                  CFStringEncoding(CFStringEncodings.windowsArabic.rawValue)
              )
          )
    
}
