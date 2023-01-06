//
//  SignUpViewController.swift
//  CoreData-Blog
//

//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    // MARK: - UI Properties
    private let titleBorderView: UIView = {
        let view = UIView()
        view.layer.borderColor = Colors.shared.blue.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = Colors.shared.blue
        return label
    }()

    private let loginImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private let borderOne: UIView = {
        let view = UIView()
        view.layer.borderColor = Colors.shared.blue.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 15
        return view
    }()

    private let borderTwo: UIView = {
        let view = UIView()
        view.layer.borderColor = Colors.shared.blue.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 15
        return view
    }()

    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Please enter your login"
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.textAlignment = .center
        textField.placeholder = "Please enter your password"
        return textField
    }()

    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Register ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderColor = Colors.shared.blue.cgColor
        button.layer.backgroundColor = Colors.shared.blue.cgColor
        button.layer.borderWidth = 1
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStyle()
        arrangeSubviews()
        setupConstraints()
        bind()
    }

    func setupStyle() {
        view.backgroundColor = .white
    }

    func arrangeSubviews() {
        view.addSubviews([titleBorderView, borderOne, borderTwo, registerButton, loginImageView])
        titleBorderView.addSubview(titleLabel)
        borderOne.addSubview(loginTextField)
        borderTwo.addSubview(passwordTextField)
    }

    func setupConstraints() {
        titleBorderView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(75)
        }

        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        borderOne.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-30)
            $0.leading.trailing.equalTo(titleBorderView)
            $0.height.equalTo(40)
        }

        loginTextField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        borderTwo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(borderOne.snp.bottom).offset(20)
            $0.size.equalTo(borderOne)
        }

        passwordTextField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        registerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(borderTwo.snp.bottom).offset(20)
            $0.width.equalTo(passwordTextField.snp.width).multipliedBy(0.5)
        }

        loginImageView.snp.makeConstraints {
            $0.top.equalTo(titleBorderView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(titleBorderView).inset(10)
            $0.bottom.equalTo(borderOne.snp.top).offset(-20)
        }
    }

    func bind() {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
}

private extension SignUpViewController {
    @objc
    func registerButtonTapped() {
        guard let login = loginTextField.text,
              let password = passwordTextField.text else { return }

        if !login.isEmpty, !password.isEmpty {
            CoreDataManager.shared.addNewUser(by: UserModel(login: login, password: password))
            loginTextField.text = ""
            passwordTextField.text = ""
            dismiss(animated: true)
        } else {
            let alert = UIAlertController(title: "Fill fields",
                                          message: "Can't create account with empty fields!",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

