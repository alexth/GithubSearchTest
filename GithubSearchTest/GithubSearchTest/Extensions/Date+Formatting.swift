//
//  Date+Formatting.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//

import Foundation

extension Date {
    static func formatDate(string: String) -> Date {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: string) else {
            fatalError("ERROR! Unable to format date")
        }
        
        return date
    }
}
