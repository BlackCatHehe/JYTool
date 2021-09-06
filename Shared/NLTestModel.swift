//
//  NLTestModel.swift
//  JYModelTool
//
//  Created by black on 2021/9/6.
//

import Foundation
import SwiftyJSON

struct NLTagModel {
    var tab: String = ""
    var color: String = ""
    
    init() {}
    init(json: JSON) {
        tab = json["tab"].string ?? ""
        color = json["color"].string ?? ""
    }
}


struct NLFinishedModel {
    var name: String = ""
    
    init() {}
    init(json: JSON) {
        name = json["name"].string ?? ""
    }
}


struct NLTestModel {
    var language: String = ""
    var last_chapter_id: Int = 0
    var total_views: Int = 0
    var tag: [NLTagModel] = []
    var hot_num: String = ""
    var descriptionField: String = ""
    var vertical_cover: String = ""
    var cover: String = ""
    var author: String = ""
    var is_finished: Int = 0
    var total_chapter: Int = 0
    var name: String = ""
    var finished: NLFinishedModel = .init()
    var update_time: Int = 0
    var book_id: Int = 0
    
    init() {}
    init(json: JSON) {
        language = json["language"].string ?? ""
        last_chapter_id = json["last_chapter_id"].int ?? 0
        total_views = json["total_views"].int ?? 0
        tag = (json["tag"].array ?? []).map{NLTagModel(json: $0)}
        hot_num = json["hot_num"].string ?? ""
        descriptionField = json["description"].string ?? ""
        vertical_cover = json["vertical_cover"].string ?? ""
        cover = json["cover"].string ?? ""
        author = json["author"].string ?? ""
        is_finished = json["is_finished"].int ?? 0
        total_chapter = json["total_chapter"].int ?? 0
        name = json["name"].string ?? ""
        finished = NLFinishedModel(json: json["finished"])
        update_time = json["update_time"].int ?? 0
        book_id = json["book_id"].int ?? 0
    }
}
