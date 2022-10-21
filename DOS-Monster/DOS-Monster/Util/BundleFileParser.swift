//
//  BundleFileParser.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/21.
//

import Foundation

struct BundleFileParser<Model: Decodable> { // TODO: 리턴값 Single타입으로 변경, 얘는 Service인가?
    static func request(fileName: String, extension: String) -> Result<Model, DataFetchError> {
        // 내부에 JSON 파일로 저장하지 말고 서버에 저장해서 불러오기?
        guard let url = Bundle.main.url(forResource: fileName, withExtension: `extension`),
              let data = try? Data(contentsOf: url) else {
            return .failure(.fileNotFound)
        }
        
        if let decodedData = JSONConvertService<Model>.decode(data: data) {
            return .success(decodedData)
        } else {
            return .failure(.failToDecode)
        }
    }
}
