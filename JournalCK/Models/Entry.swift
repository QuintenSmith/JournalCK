//
//  Entry.swift
//  JournalCK
//
//  Created by Quinten Smith on 9/24/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation
import CloudKit

struct Constants {
    static let recordKey = "Entry"
    static let titleKey = "Title"
    static let bodyKey = "Body"
}

class Entry {
    
    let title: String
    let bodyText: String
    let ckRecordID: CKRecord.ID
    
    init(title: String, bodyText: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.bodyText = bodyText
        self.ckRecordID = ckRecordID
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[Constants.titleKey] as? String,
            let bodyText = ckRecord[Constants.bodyKey] as? String else {return nil}
        
        self.init(title: title, bodyText: bodyText, ckRecordID: ckRecord.recordID)
    }
    
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: Constants.recordKey)
        self.setValue(entry.title, forKey: Constants.titleKey)
        self.setValue(entry.bodyText, forKey: Constants.bodyKey)
    }
}
