//
//  Constants.swift
//  NKConstants
//
import Foundation

public struct Constants {
    
    //MARK:- Don't rename cases because them rawValue uses for request path
    public enum UserStatus: String {
        case AVAILABLE
        case UNAVAILABLE
        case REJOIN_QUEUE
        case STILL_AVAILABLE
        case NO_MORE_AVAILABLE
    }
    
    //MARK:- Don't rename cases because them rawValue uses for request path
    public enum CallActivity: String {
        /* When to send: Whenever the clerk leaves a call. */
        case CALL_DISCONNECTED_BY_CLERK
        
        /* When to send: When the consumer leaves the call before it is answered.
        In android we do in the onConnectionDestroyed() handeler when isCallAnswered is false. */
        case CALL_ABORT_BY_CONSUMER
        
        /* When to send: When the survey is posted successfully. */
        case SURVEY_ANSWERED
        
        /* When to send: When the survey tiems out. */
        case SURVEY_TIMEDOUT
        
        /* When to send: When the survey is neither posted successfully not timedout. */
        case SURVEY_UNANSWERED
        
        /* When to send: When their is no consumer in the call and the clerk joins the call, only to wait for a certain time and then end the call. In android this activity is sent when the consumer timeout timer runs out and calls the callback method, in the callback method this activity is logged. */
        case CALL_ENDED_AUTO_NO_CALLER
        
        /* When to send: When Clerk choose to leave the appointment */
        case BOOKING_CLERK_LEFT
        
        /* When to send: When Clerk choose to end the appointment for all the candidates */
        case BOOKING_ENDED
        
        /* When to send: When Clerk join the appointment */
        case BOOKING_CLERK_JOINED
        
        /* When to send: When Clerk rejects the new call while already in a call (double call) */
        case CALL_DECLINED_ON_CALL
        
        /* When to send: When iOS device receive any notification */
        case CALL_RECEIVED_BY_DEVICE
        
        /* When to send: When iOS app starts ringing call*/
        case CALL_RINGING_ON_DEVICE
        
        /* When to send: When iOS app submit survey */
        case CLERK_SURVEY_SHOWN
        
        /* When to send: When iOS app initiate chat */
        case CALL_CHAT_STARTED_IN_CALL
        
    }
    
    //MARK:- OpenTok keys
    public struct OpenTokKeys {
        public static var addProductToBasket: String = "ADD-TO-BASKET"
        public static var chatInitiated: String = "CHAT_INITIATED"
    }
    
    // MARK: Network Layer Constants - Base URL
    public struct BaseURL {
        
        public static var environmentBaseURL : String {
            switch NetworkManager.shared.environment {
            case .SIT:
                return ""
            case .STAGING:
                return ""
            case .DEMO:
                return ""
            case .PROD:
                return ""
            case .CSI:
                return ""
            case .REG:
                return ""
            case .DEV:
                return "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com"
            }
        }
        
    }
    
    // MARK: Network Layer Constants - Path URL
    public struct PathURL {
        
        public static func itemLink() -> String {
            return "/default/dynamodb-writer"
        }
    }
    
    // MARK: Network Layer Constants - Parameters name
    public struct Parameters {
        public static let requestInJSON = "requestInJSON"
        public static let activityData = "activityData"
        public static let timeToAnswer = "timeToAnswer"
        public static let callUUID = "callUUID"
        public static let reason = "reason"
        public static let searchString = "searchString"
        public static let callId = "callId"
        public static let clerkId = "clerkId"
        public static let currysSearchProduct = "q"
        public static let authentication = "authentication"
    }
    
    // MARK: Network Layer Constants - Parameters value
    public struct ParametersValue {
        //example : public static let testValue = "sxjsfo8NdO9LzR7e7gYY27fOGp32I2DKyBn"
    }
    
    // MARK: Network Layer Constants - Headers
    public struct Headers {
        //example:
        //        public static let authorization = "Authorization"
        public static let authToken = "auth_token"
        public static let contentType = "Content-Type"
        public static let applicationJson = "application/json"
        
        // chat headers
        public static let appId = "appId"
        public static let Accept = "Accept"
        public static let apiKey = "apiKey"
        
    }
}
