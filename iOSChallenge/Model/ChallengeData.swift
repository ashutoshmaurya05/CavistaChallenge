//
//  ChallengeData.swift
//  iOSChallenge
//
//  Created by Ashutosh Maurya on 31/10/20.
//

import Foundation

struct ChallengeData: Codable,Identifiable {
    var id: String
    var type: String
    var date: String?
    var data: String?
}
