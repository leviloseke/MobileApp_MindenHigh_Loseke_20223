//
//  ReportBugViewController.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 2/8/23.
//
import UIKit
import MessageUI

class ReportBugViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!

    @IBOutlet weak var descriptionTextView: UITextField!

    
    @IBOutlet weak var submitButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["levi.loseke@gmail.com"])
            mail.setSubject(titleTextField.text!)
            mail.setMessageBody(descriptionTextView.text!, isHTML: false)
            present(mail, animated: true)
        } else {
            showErrorAlert()
        }
    }
    
    func setUpElements() {
        Utilities.styleHollowButton(submitButton)
    }
    

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        showSuccessAlert()
    }

    func showSuccessAlert() {
        let alertController = UIAlertController(title: "Success", message: "Your bug report has been sent successfully.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    func showErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "Your device is not able to send emails.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
