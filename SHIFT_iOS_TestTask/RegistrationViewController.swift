//
//  RegistrationViewController.swift
//  SHIFT_iOS_TestTask
//
//  Created by Артём on 15.07.2025.
//

import UIKit

class RegistrationViewController: UIViewController {
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let label = UILabel()
    private let datePicker = UIDatePicker()
    private let passwordTextField = UITextField()
    private let registerButton = UIButton()
    private let errorLabel = UILabel()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        super.viewDidLoad()
        setupNameFields()
        setupBirthDate()
        setupPassword()
        setupRegistrationButton()
        setupErrorLabel()
        updateRegisterButtonState()
    }
    
    func setupNameFields() {
        setupNameTextField(for: nameTextField, placeholder: "Введите имя...")
        setupNameTextField(for: surnameTextField, placeholder: "Введите фамилию...")
        
        nameTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        surnameTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupNameTextField(for textField: UITextField, placeholder: String?) {
        view.addSubview(textField)
        
        textField.placeholder = placeholder
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.cornerRadius = 10
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 250),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupBirthDate() {
        label.text = "Дата рождения:"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
                
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 25),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75),
            
            datePicker.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75)
        ])
    }
    
    func setupPassword() {
        setupNameTextField(for: passwordTextField, placeholder: "Введите пароль...")
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        passwordTextField.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20).isActive = true
    }
    
    func setupRegistrationButton() {
        registerButton.setTitle("Регистрация", for: .normal)
        registerButton.backgroundColor = .systemBlue
        registerButton.layer.cornerRadius = 10
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 250),
            registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupErrorLabel() {
        errorLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        errorLabel.textColor = .systemRed
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.text = nil
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 16),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func textFieldsChanged() {
        updateRegisterButtonState()
    }
    
    private func updateRegisterButtonState() {
        let isFormFilled = !(nameTextField.text?.isEmpty ?? true) && !(surnameTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true)
        //registerButton.isEnabled = isFormFilled
        registerButton.alpha = isFormFilled ? 1.0 : 0.5
    }
    
    @objc func registerButtonTapped() {
        let isFormFilled = !(nameTextField.text?.isEmpty ?? true) && !(surnameTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true)
        
        if isFormFilled {
            errorLabel.text = nil
            UserDefaults.standard.set(nameTextField.text, forKey: "userName")
            
            let mainViewController = MainViewController()
            self.navigationController?.pushViewController(mainViewController, animated: true)
            
            nameTextField.text = nil
            surnameTextField.text = nil
            datePicker.date = Date()
            passwordTextField.text = nil
            updateRegisterButtonState()
        } else {
            errorLabel.text = "Для входа необходимо заполнить все окна"
        }
    }
}
