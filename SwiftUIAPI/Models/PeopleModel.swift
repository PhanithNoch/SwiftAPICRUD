//
//  Comments.swift
//  SwiftUIAPI
//
//  Created by Admin on 3/23/21.
//

import Foundation

struct PeopleModel: Decodable {
    let data:[People]
}


struct People:Decodable,Identifiable,Equatable {
    var id: Int?
    let first_name: String
    let last_name: String
    let age : String
    let active_date: String
    let created_at: String
    let updated_at:String
}
