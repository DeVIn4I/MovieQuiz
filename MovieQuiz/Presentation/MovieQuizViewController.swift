import UIKit
import SnapKit

final class MovieQuizViewController: UIViewController {
    
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image: "The Godfather",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Dark Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Avengers",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Deadpool",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Kill Bill",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Green Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Old",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Tesla",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Vivarium",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
    ]
    
    private var currentQuestionIndex: Int = 0
    private var correctAnswers: Int = 0
    
    private lazy var questionTitleLabel: UILabel = {
        let label = UILabel(
            text: "Вопрос:",
            font: .ysDisplayMedium,
            size: 20,
            color: .ypWhite
        )
        return label
    }()
    
    private lazy var indexLabel: UILabel = {
        let label = UILabel(
            text: "1/10",
            font: .ysDisplayMedium,
            size: 20,
            color: .ypWhite,
            alignment: .right
        )
        return label
    }()
    
    private lazy var questionsIndexStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [questionTitleLabel, indexLabel])
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Deadpool")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel(
            text: "Рейтинг этого фильма меньше чем 5?",
            font: .ysDisplayBold,
            size: 23,
            color: .ypWhite,
            alignment: .center,
            numberOfLines: 2)
        return label
    }()
    
    private lazy var noButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            let currentQuestion = questions[currentQuestionIndex]
            let givenAnwer = false
            showAnswerResult(isCorrect: givenAnwer == currentQuestion.correctAnswer)
        }, for: .touchUpInside)
        btn.setTitle("Нет", for: .normal)
        btn.setTitleColor(.ypBlack, for: .normal)
        btn.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .ypWhite
        return btn
    }()
    
    private lazy var yesButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            let currentQuestion = questions[currentQuestionIndex]
            let givenAnwer = true
            showAnswerResult(isCorrect: givenAnwer == currentQuestion.correctAnswer)
        }, for: .touchUpInside)
        btn.setTitle("Да", for: .normal)
        btn.setTitleColor(.ypBlack, for: .normal)
        btn.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .ypWhite
        return btn
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [noButton, yesButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var commonStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                questionsIndexStackView,
                previewImageView,
                questionLabel,
                buttonsStackView])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        show(quize: convert(model: questions[currentQuestionIndex]))
    }
    
    private func setupViews() {
        view.backgroundColor = .ypBlack
        view.addSubview(commonStackView)
    }
    
    private func setConstraints() {
        previewImageView.snp.makeConstraints {
            $0.width.equalTo(previewImageView.snp.height).multipliedBy(2.0 / 3.0)
        }
        buttonsStackView.snp.makeConstraints { $0.height.equalTo(60) }
        commonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func show(quize step: QuizStepViewModel) {
        previewImageView.image = step.image
        questionLabel.text = step.question
        indexLabel.text = step.questionNumber
    }
    
    private func show(quize result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
            guard let self else { return }
           
            currentQuestionIndex = 0
            correctAnswers = 0
            let firstQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: firstQuestion)
            show(quize: viewModel)
        })
        present(alert, animated: true)
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)",
            image: UIImage(named: model.image) ?? UIImage())
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        }
        
        previewImageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        previewImageView.layer.borderWidth = 8
        previewImageView.layer.masksToBounds = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.previewImageView.layer.borderWidth = 0
            self.showNextQuestionOrResult()
        }
    }
    
    private func showNextQuestionOrResult() {
        if currentQuestionIndex == questions.count - 1 {
            let text = "Ваш результат: \(correctAnswers) из \(questions.count)"
            let viewModel = QuizResultsViewModel(
                title: "Раунд закончен",
                text: text,
                buttonText: "Сыграть еще раз")
            show(quize: viewModel)
            
        } else {
            currentQuestionIndex += 1
            let nextQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: nextQuestion)
            show(quize: viewModel)
        }
    }
}
