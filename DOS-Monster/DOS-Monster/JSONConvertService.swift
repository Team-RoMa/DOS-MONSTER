//
//  JSONConvertService.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/11.
//

import Foundation

struct JSONConvertService<T> {
    typealias Model = T
    
    static func decode(data: Data) -> Model? where Model: Decodable {
        guard let json = try? JSONDecoder().decode(Model.self, from: data) else { return nil }
        return json
    }
    
    static func encode<Model: Encodable>(model: Model) -> Data? {
        guard let data = try? JSONEncoder().encode(model) else { return nil }
        return data
    }
}
