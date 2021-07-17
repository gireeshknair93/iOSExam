//
//  Data+Extension.swift
//  Taxi
//
//  Created by SELLADURAI on 2/10/19.
//  Copyright © 2019 Virtue Sense. All rights reserved.
//

import Foundation

extension Data {
    
    func getDecodedObject<T>(from object : T.Type)->T? where T : Decodable {
        
        do {
            
            return try JSONDecoder().decode(object, from: self)
            
        } catch let error {
            
            print("Manually parsed  ", (try? JSONSerialization.jsonObject(with: self, options: .mutableContainers)) ?? "nil")
            
            print("Error in Decoding OBject ", String(describing: error))
            return nil
        }
        
    }
    func decodeToModel<Model: Decodable>(modelType: Model.Type) throws -> AnyObject {
        do {
            let model = try JSONDecoder().decode(modelType, from: self) as AnyObject
            return model
        } catch let DecodingError.keyNotFound(key, context) {
            print("key '\(key)' not found:", context.debugDescription)
            throw JSONDecodeError(context: context, kind: .keyNotFound)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            throw JSONDecodeError(context: context, kind: .typeMismatch)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' mismatch:", context.debugDescription)
            throw JSONDecodeError(context: context, kind: .valueNotFound)
        } catch let DecodingError.dataCorrupted(context) {
            print(context.debugDescription)
            throw JSONDecodeError(context: context, kind: .dataCorrupted)
        } catch {
            print("error: ", error)
            throw JSONDecodeError(context: nil, kind: .generic)
        }
    }
    
    
}
