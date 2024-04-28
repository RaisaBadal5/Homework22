//
//  ViewController.swift
//  CountriesApp
//
//  Created by Default on 28.04.24.
//

import UIKit
import Security

protocol SecondViewControllerDelegate: AnyObject {
    func showAlertInSecondPage()
}

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var mainView: UIView = {
        let mv = UIView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()
    
    var imageView: UIImageView = {
        let im = UIImageView()
        im.translatesAutoresizingMaskIntoConstraints = false
        return im
    }()
    
    var button: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    var labelForName: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var textFieldForName: UITextField = {
        let tx = UITextField()
        tx.translatesAutoresizingMaskIntoConstraints = false
        return tx
    }()
    
    var labelForPassword: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var textFieldForPassword: UITextField = {
        let tx = UITextField()
        tx.translatesAutoresizingMaskIntoConstraints = false
        return tx
    }()
    
    var labelForRepeatPassword: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var textFieldForRepeatPassword: UITextField = {
        let tx = UITextField()
        tx.translatesAutoresizingMaskIntoConstraints = false
        return tx
    }()
    
    var buttonForSecondPage: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainView)
        mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        mainView.isUserInteractionEnabled = true
        mainView.backgroundColor = UIColor.white
        setUpImageView()
        setUpButton()
        setUplabelForName()
        setUptextFieldForName()
        setUplabelForPassword()
        setUptextFieldForPassword()
        setUplabelForRepeatPassword()
        setUptextFieldForRepeatPassword()
        setUpbuttonForSecondPage()
        checkFirstTimeLogin()
    }
    
    weak var delegate: SecondViewControllerDelegate?
    
    func checkFirstTimeLogin() {
        let isFirstTimeLogin = !UserDefaults.standard.bool(forKey: "FirstTimeLogin")
        if isFirstTimeLogin {
            UserDefaults.standard.set(true, forKey: "FirstTimeLogin")
            delegate?.showAlertInSecondPage()
        } else {
            if let username = UserDefaults.standard.string(forKey: "Username") {
                textFieldForName.text = username
                if let password = getPasswordFromKeychain(username: username) {
                    textFieldForPassword.text = password
                }
            }
        }
    }
    
    func savePasswordToKeychain(username: String, password: String) {
        let passwordData = Data(password.utf8)
        
        do {
            try KeychainService.shared.savePassword(username: username, password: passwordData)
        } catch {
            print("Error saving password to Keychain: \(error)")
        }
    }
    
    func getPasswordFromKeychain(username: String) -> String? {
        do {
            let passwordData = try KeychainService.shared.getPassword(username: username)
            return String(data: passwordData, encoding: .utf8)
        } catch {
            print("Error retrieving password from Keychain: \(error)")
            return nil
        }
    }
    
    func authenticateUser() {
        guard let username = textFieldForName.text, let password = textFieldForPassword.text else {
            return
        }
        
        savePasswordToKeychain(username: username, password: password)
        UserDefaults.standard.set(username, forKey: "Username")
        
        let isFirstTimeLogin = !UserDefaults.standard.bool(forKey: "FirstTimeLogin")
        if isFirstTimeLogin {
            UserDefaults.standard.set(true, forKey: "FirstTimeLogin")
            delegate?.showAlertInSecondPage()
        }
        
        navigateToSecondPage()
    }
    
    func navigateToSecondPage() {
        let secondVC = ViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Greetings", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func buttonOpenGallery(sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            imageView.image = image
            saveImageToDocumentsDirectory(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func saveImageToDocumentsDirectory(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 1.0) else { return }
        let filename = getDocumentsDirectory().appendingPathComponent("savedImage.jpg")
        do {
            try data.write(to: filename)
        } catch {
            print("Error saving image: \(error)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setUpImageView() {
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        mainView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 132).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 132).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 110).isActive = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
    }
    
    func setUpButton() {
        button.setTitle("Open Gallery", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonOpenGallery), for: .touchUpInside)
        mainView.addSubview(button)
        button.isUserInteractionEnabled = true
        button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    func setUplabelForName() {
        mainView.addSubview(labelForName)
        labelForName.widthAnchor.constraint(equalToConstant: 200).isActive = true
        labelForName.heightAnchor.constraint(equalToConstant: 13).isActive = true
        labelForName.topAnchor.constraint(equalTo: button.topAnchor, constant: 50).isActive = true
        labelForName.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        labelForName.text = "მომხმარებლის სახელი"
        labelForName.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        labelForName.textAlignment = .left
        labelForName.textColor = UIColor.black
    }
    
    func setUptextFieldForName() {
        mainView.addSubview(textFieldForName)
        textFieldForName.widthAnchor.constraint(equalToConstant: 327).isActive = true
        textFieldForName.heightAnchor.constraint(equalToConstant: 45).isActive = true
        textFieldForName.topAnchor.constraint(equalTo: labelForName.bottomAnchor, constant: 20).isActive = true
        textFieldForName.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        textFieldForName.layer.cornerRadius = 23
        textFieldForName.backgroundColor = UIColor.lightGray
        textFieldForName.isUserInteractionEnabled = true
        textFieldForName.placeholder = "შეიყვანეთ მომხმარებლის სახელი"
        textFieldForName.textColor = UIColor.black
    }
    
    func setUplabelForPassword() {
        mainView.addSubview(labelForPassword)
        labelForPassword.widthAnchor.constraint(equalToConstant: 200).isActive = true
        labelForPassword.heightAnchor.constraint(equalToConstant: 13).isActive = true
        labelForPassword.topAnchor.constraint(equalTo: textFieldForName.topAnchor, constant: 80).isActive = true
        labelForPassword.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        labelForPassword.text = "პაროლი"
        labelForPassword.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        labelForPassword.textAlignment = .left
        labelForPassword.textColor = UIColor.black
    }
    
    func setUptextFieldForPassword() {
        mainView.addSubview(textFieldForPassword)
        textFieldForPassword.widthAnchor.constraint(equalToConstant: 327).isActive = true
        textFieldForPassword.heightAnchor.constraint(equalToConstant: 45).isActive = true
        textFieldForPassword.topAnchor.constraint(equalTo: labelForPassword.bottomAnchor, constant: 20).isActive = true
        textFieldForPassword.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        textFieldForPassword.layer.cornerRadius = 23
        textFieldForPassword.backgroundColor = UIColor.lightGray
        textFieldForPassword.isSecureTextEntry = true
        textFieldForPassword.isUserInteractionEnabled = true
        textFieldForPassword.placeholder = "შეიყვანეთ პაროლი"
        textFieldForPassword.textColor = UIColor.black
    }
    
    func setUplabelForRepeatPassword() {
        mainView.addSubview(labelForRepeatPassword)
        labelForRepeatPassword.widthAnchor.constraint(equalToConstant: 200).isActive = true
        labelForRepeatPassword.heightAnchor.constraint(equalToConstant: 13).isActive = true
        labelForRepeatPassword.topAnchor.constraint(equalTo: textFieldForPassword.topAnchor, constant: 80).isActive = true
        labelForRepeatPassword.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        labelForRepeatPassword.text = "გაიმეორეთ პაროლი"
        labelForRepeatPassword.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        labelForRepeatPassword.textAlignment = .left
        labelForRepeatPassword.textColor = UIColor.black
    }
    
    func setUptextFieldForRepeatPassword() {
        mainView.addSubview(textFieldForRepeatPassword)
        textFieldForRepeatPassword.widthAnchor.constraint(equalToConstant: 327).isActive = true
        textFieldForRepeatPassword.heightAnchor.constraint(equalToConstant: 45).isActive = true
        textFieldForRepeatPassword.topAnchor.constraint(equalTo: labelForRepeatPassword.bottomAnchor, constant: 20).isActive = true
        textFieldForRepeatPassword.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        textFieldForRepeatPassword.layer.cornerRadius = 23
        textFieldForRepeatPassword.backgroundColor = UIColor.lightGray
        textFieldForRepeatPassword.isSecureTextEntry = true
        textFieldForRepeatPassword.isUserInteractionEnabled = true
        textFieldForRepeatPassword.placeholder = "განმეორებით შეიყვანეთ პაროლი"
        textFieldForRepeatPassword.textColor = UIColor.black
    }
    
    func setUpbuttonForSecondPage() {
        mainView.addSubview(buttonForSecondPage)
        buttonForSecondPage.widthAnchor.constraint(equalToConstant: 327).isActive = true
        buttonForSecondPage.heightAnchor.constraint(equalToConstant: 45).isActive = true
        buttonForSecondPage.topAnchor.constraint(equalTo: textFieldForRepeatPassword.bottomAnchor, constant: 50).isActive = true
        buttonForSecondPage.leadingAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        buttonForSecondPage.layer.cornerRadius = 23
        buttonForSecondPage.setTitle("Go to Second Page", for: .normal)
        buttonForSecondPage.backgroundColor = UIColor.blue
        buttonForSecondPage.addTarget(self, action: #selector(buttonForSecondPageTapped), for: .touchUpInside)
    }
    
    @objc func buttonForSecondPageTapped() {
        let secondVC = ViewController()
        navigationController?.pushViewController(secondVC, animated: true)
        authenticateUser()
    }
}
