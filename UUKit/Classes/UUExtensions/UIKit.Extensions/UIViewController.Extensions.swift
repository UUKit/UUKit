//
//  UIViewControllerExtensions+Contacts.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/8/5.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI


fileprivate var contact: ((_ name: String?,_ phone: String?)->Void)?

// MARK: - 联系人Contacts
@available(iOS 9.0, *)
extension UIViewController: CNContactPickerDelegate {
    /// 获取联系人姓名，手机号码
    ///
    /// - Parameter info: 电话 手机号码
    public func getContact(Info:((_ name: String?,_ phone: String?)->Void)?) {
        contact = Info
        checkAuthorzation { presentContactPickerViewController() }
    }
    
    private func checkAuthorzation(completion: ()->Void) {
        let status = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        if status == .authorized || status == .notDetermined {
            completion()
        } else {
            let alert = UIAlertController(title: nil, message: "请到设置>隐私>通讯录,打开本应用的权限设置", preferredStyle: .alert)
            let action = UIAlertAction(title: "好", style: .default, handler: { (alert) in
                
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func presentContactPickerViewController() {
        let vc = CNContactPickerViewController()
        vc.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    //delegate
    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        let number = contactProperty.value as? CNPhoneNumber
        let name = contactProperty.contact.familyName + contactProperty.contact.givenName
        let phone = number?.stringValue
        guard let c = contact else { return print("未获取到联系人信息") }
        c(name,phone)
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - 文件预览
extension UIViewController {
    
    
    
    
    
    
}


