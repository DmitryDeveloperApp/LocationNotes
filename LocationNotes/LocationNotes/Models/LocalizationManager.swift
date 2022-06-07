//
//  LocalizationManager.swift
//  LocationNotes
//
//  Created by Dmitry Suprun on 07.06.2022.
//

import Foundation


extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
