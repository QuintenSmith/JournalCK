                                                                                                                                                                                                                                                                                                          //
//  EntryController.swift
//  JournalCK
//
//  Created by Quinten Smith on 9/24/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    static let shared = EntryController()
    
    private init() {}
    
    var entries: [Entry] = []
    
    func save(entry: Entry, completion: @escaping (Bool) -> ()) {
        let recordEntry = CKRecord(entry: entry)
        CKContainer.default().privateCloudDatabase.save(recordEntry) { (record, error) in
            if let error = error {
                print("There was an error in \(#function); \(error); \(error.localizedDescription)")
                completion(false); return
            }
            guard let record = record, let entry = Entry(ckRecord: record) else {completion(false); return}
            self.entries.append(entry)
            completion(true)
        }
    }
    
    func addEntryWith(title: String, bodyText: String, completion: @escaping(Bool) -> Void) {
        let entry = Entry(title: title, bodyText: bodyText)
        self.save(entry: entry) { (success) in
            if success{
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func fetchEntries(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: Constants.recordKey, predicate: predicate)
        
        CKContainer.default().privateCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("There was an error in \(#function); \(error); \(error.localizedDescription)")
                completion(false); return
            }
            guard let records = records else {completion(false); return}
            let entries = records.compactMap{ Entry(ckRecord: $0)}
            self.entries = entries
            completion(true)
        }
    }
    
    
}

