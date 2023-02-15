//
//  ProfileViewController.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 2/12/23.
//
import FirebaseAuth
import FirebaseFirestore
import UIKit
import MessageUI


class ProfileViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var fullName: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
        
        
        // Reference to the Firestore database
        let db = Firestore.firestore()
        
        // Get the current user ID
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Error: current user's uid is nil")
            return
        }
        
        // Query to retrieve the document with the uid field equal to the current user's uid
        let userRef = db.collection("users").whereField("uid", isEqualTo: currentUserID)
        
        // Retrieve the data from the user document
        userRef.getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot, !querySnapshot.isEmpty {
                // Get the first document from the query
                let document = querySnapshot.documents[0]
                // Get the first name and last name from the document
                guard let firstName = document.get("firstname") as? String else {
                    print("Error: firstname field is nil")
                    return
                }
                guard let lastName = document.get("lastname") as? String else {
                    print("Error: lastname field is nil")
                    return
                }
                // Apply the first name and last name to the label
                // Set the fullName property to the concatenated first name and last name
                self.fullName = "\(firstName) \(lastName)"
                self.nameLabel.text = "\(firstName) \(lastName)"
            } else {
                print("Error retrieving user data: \(error)")
            }
        }
    }
    func setUpElements() {
        Utilities.styleHollowButton(submitButton)
    }
    
    @IBAction func sendEmailButtonTapped(_ sender: UIButton) {
        // Check if the device can send email
        
        // Show an alert to indicate that the email was sent
        let alert = UIAlertController(title: "Absence Notification", message: "An absence notification has been sent.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        
        if MFMailComposeViewController.canSendMail() {
            // Create the email composition view controller
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            // Set the recipient email address
            mailComposer.setToRecipients(["levi.loseke@gmail.com"])
            
            // Set the email subject
            mailComposer.setSubject("Absence Notification")
            
            // Get the date from the date picker
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let date = dateFormatter.string(from: datePicker.date)
            
            // Set the email body
            mailComposer.setMessageBody("<p>To School</p><p> <b>\(fullName))</b> will be absent on <b>\(date)</b>.", isHTML: true)
        }
    }
}
