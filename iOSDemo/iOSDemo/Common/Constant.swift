//
//  Constant.swift
//  iOSDemo
//
//  Created by Uroosa on 07/22/22.
//

import UIKit

let URL_issLocation = "http://api.open-notify.org/iss-now.json"

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
