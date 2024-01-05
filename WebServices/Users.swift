//
//  Users.swift
//  WebServices
//
//  Created by Mac on 05/01/24.
//

import Foundation
struct Users
{
    var page : Int
    var per_page : Int
    var total : Int
    var total_pages : Int
    var data : [Data]
}
struct Data
{
    var id : Int
    var first_name : String
    var last_name : String
    var avatar : String
    
}
