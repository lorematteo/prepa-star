//
//  SwiftUIView.swift
//  Quizz
//
//  Created by matteo on 30/06/2021.
//

import SwiftUI
import MessageUI

struct MailComposeViewController: UIViewControllerRepresentable {
    
    @Binding var result: Result<MFMailComposeResult, Error>?
    @Binding var resulttype: String
    
    @Binding var toRecipients: [String]
    @Binding var subject: String
    @Binding var mailBody: String
    
    var didFinish: ()->()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self, result: $result, resulttype: $resulttype)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailComposeViewController>) -> MFMailComposeViewController {
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = context.coordinator
        mail.setToRecipients(self.toRecipients)
        mail.setMessageBody(self.mailBody, isHTML: false)
        mail.setSubject(self.subject)
        
        return mail
    }
    
    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        @Binding var result: Result<MFMailComposeResult, Error>?
        @Binding var resulttype: String
        var parent: MailComposeViewController
        
        init(_ mailController: MailComposeViewController, result: Binding<Result<MFMailComposeResult, Error>?>, resulttype: Binding<String>) {
            self.parent = mailController
            _result = result
            _resulttype = resulttype
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            switch result.rawValue {
                case MFMailComposeResult.cancelled.rawValue:
                    self.resulttype = "cancelled"
                case MFMailComposeResult.saved.rawValue:
                    self.resulttype = "saved"
                case MFMailComposeResult.sent.rawValue:
                    self.resulttype = "sent"
                case MFMailComposeResult.failed.rawValue:
                    self.resulttype = "failed"
                default:
                    break
            }
            parent.didFinish()
            controller.dismiss(animated: true)
        }
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailComposeViewController>) {
        
    }
}
