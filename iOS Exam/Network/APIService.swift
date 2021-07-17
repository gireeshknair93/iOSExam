//
//  APIService.swift
//  TaxiPickup

import Foundation
class APIService: NSObject, APIServiceProtocol{
    public func loadMockData<Model: Decodable>(fileName: String, modelType: Model.Type, completion: APIParsedResponse) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let model = try data.decodeToModel(modelType: modelType)
                completion(ResponseCode.success, model, nil)
            } catch let JSONDecodeError {
                print(JSONDecodeError)
                completion(ResponseCode.serviceError, nil, nil)
            }
        }
    }
    func connectNetwork<Model: Decodable>(modelType: Model.Type, withBaseURl baseURL: String, withParameters parameters: String, withHttpMethod httpMethod: String, withContentType contentType: String, completion: @escaping APIParsedResponse) {
        
    }
}

extension String {
    func encodeURL() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
}
