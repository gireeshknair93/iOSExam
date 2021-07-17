//
//  APIServiceProtocol.swift
//  Network

import Foundation

public class ServiceError: NSError {
    public override init(domain: String, code: Int, userInfo dict: [String : Any]? = nil) {
        super.init(domain: domain, code: code, userInfo: dict)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public struct JSONDecodeError: Error {
    enum ErrorKind {
        case dataCorrupted
        case keyNotFound
        case valueNotFound
        case typeMismatch
        case generic
    }
    var context: DecodingError.Context?
    var kind: ErrorKind?
}

public enum ResponseCode: Equatable {
    public static func == (lhs: ResponseCode, rhs: ResponseCode) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return true
        default:
            return false
        }
    }
    case success
    case serviceError
    case networkError
    case jsonDecodeError
}

public typealias APIParsedResponse = (_ code: ResponseCode, _ response: AnyObject?, _ error: ServiceError?) -> Void
public protocol APIServiceProtocol {
    func connectNetwork<Model: Decodable>(modelType: Model.Type, withBaseURl baseURL: String, withParameters parameters: String, withHttpMethod httpMethod: String, withContentType contentType: String, completion: @escaping APIParsedResponse)
}
