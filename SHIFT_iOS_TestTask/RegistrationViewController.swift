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
    private let passwordTextField = UITextField()
    private let registerButton = UIButton()
    private let errorLabel = UILabel()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
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
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
            surnameTextField.centerYAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40)
        ])
    }
    
    private func setupNameTextField(for textField: UITextField, placeholder: String?) {
        view.addSubview(textField)
        
        textField.placeholder = placeholder
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.cornerRadius = 10
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 250),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupBirthDate() {
        let label = UILabel()
        label.text = "Дата рождения:"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
                
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupPassword() {
        setupNameTextField(for: passwordTextField, placeholder: "Введите пароль...")
        
        passwordTextField.isSecureTextEntry = true
        
        passwordTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        
        passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60).isActive = true
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
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 120),
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
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 160)
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
            let mainViewController = MainViewController()
            self.navigationController?.pushViewController(mainViewController, animated: true)
            nameTextField.text = nil
            surnameTextField.text = nil
            passwordTextField.text = nil
            errorLabel.text = nil
            updateRegisterButtonState()
        } else {
            errorLabel.text = "Для входа необходимо заполнить все окна"
        }
    }
}
