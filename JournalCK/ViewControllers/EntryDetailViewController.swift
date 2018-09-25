//
//  EntryDetailViewController.swift
//  JournalCK
//
//  Created by Quinten Smith on 9/24/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var entry: Entry? {
        didSet {
        loadViewIfNeeded()
        updateViews()
        }
    }
    
    func updateViews() {
        guard let entry = entry else {return}
        nameTextField.text = entry.title
        bodyTextView.text = entry.bodyText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveBtnWasTapped(_ sender: Any) {
        guard let title = nameTextField.text, let bodyText = bodyTextView.text else {return}
        
            EntryController.shared.addEntryWith(title: title, bodyText: bodyText) { (success) in
                if success {
                    print("Success saving")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    print("No success saving")
                }
            }
    }
    
}
