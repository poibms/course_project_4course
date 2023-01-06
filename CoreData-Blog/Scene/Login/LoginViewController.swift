//
//  LoginViewController.swift
//  CoreData-Blog
//

//

import UIKit
import SnapKit

struct Colors {
    static let shared = Colors()

    let blue = UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1)
}

class LoginViewController: UIViewController {
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
        label.text = "Photo network"
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

    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Sign In ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderColor = Colors.shared.blue.cgColor
        button.backgroundColor = Colors.shared.blue
        button.layer.borderWidth = 1
        return button
    }()

    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Sign Up ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderColor = Colors.shared.blue.cgColor
        button.backgroundColor = Colors.shared.blue
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
        view.addSubviews([titleBorderView, borderOne, borderTwo, signInButton, signUpButton, loginImageView])
        titleBorderView.addSubview(titleLabel)
        borderOne.addSubview(loginTextField)
        borderTwo.addSubview(passwordTextField)
    }

    func setupConstraints() {
        titleBorderView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(75)
        }

        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        borderOne.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-10)
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

        signInButton.snp.makeConstraints {
            $0.top.equalTo(borderTwo.snp.bottom).offset(20)
            $0.leading.equalTo(borderTwo)
            $0.trailing.equalTo(view.snp.centerX).offset(-10)
        }

        signUpButton.snp.makeConstraints {
            $0.top.equalTo(borderTwo.snp.bottom).offset(20)
            $0.trailing.equalTo(borderTwo)
            $0.leading.equalTo(view.snp.centerX).offset(10)
        }

        loginImageView.snp.makeConstraints {
            $0.top.equalTo(titleBorderView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(titleBorderView).inset(10)
            $0.bottom.equalTo(borderOne.snp.top).offset(-20)
        }
    }

    func bind() {
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
}

private extension LoginViewController {
    @objc
    func signInButtonTapped() {
        guard let login = loginTextField.text,
              let password = passwordTextField.text else { return }

        let allUsers = CoreDataManager.shared.getUsers()

        if let _ = allUsers.first(where: { $0.login == login && $0.password == password }) {
            UserDefaults.standard.set(login, forKey: "login")

            let viewControllers = app.router.createTabBar()
            viewControllers.modalPresentationStyle = .fullScreen
            present(viewControllers, animated: true)

            loginTextField.text = ""
            passwordTextField.text = ""
        } else {
            let alert = UIAlertController(title: "Error",
                                          message: "This user doesn't exist!",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @objc
    func signUpButtonTapped() {
        present(SignUpViewController(), animated: true)
    }
}

