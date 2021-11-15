//
//  CellModel.swift
//  RxTableView
//
//  Created by Dugong on 2021/11/15.
//

import Foundation
import UniformTypeIdentifiers

class CellModel: NSObject, NSItemProviderWriting, Codable {
    static var writableTypeIdentifiersForItemProvider: [String] { return [String(UTType.data.identifier)] }

    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> CellModel {
        do {
            let model = try JSONDecoder().decode(CellModel.self, from: data)
            return model
        } catch {
            fatalError()
        }
    }

    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        do {
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return progress
    }

    let title: String

    let description1: String

    init(title: String, description1: String) {
        self.title = title
        self.description1 = description1
    }
}
