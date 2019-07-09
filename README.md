#  Example for Clean Swift with RxSwift

## Layers

### Application
`Application` is responsible for delivering information to the user and handling user input. It can be implemented with any delivery pattern e.g (MVVM, MVC, MVP). This is the place for your `UIView`s and `UIViewController`s.

`Application` is completely independent of the `Platform`. The only responsibility of a view controller is to "bind" the UI to the `Domain` to make things happen. 

### Platform
The `Platform` is a concrete implementation of the `Domain` in a specific platform like iOS. It does hide all implementation details. For example Database implementation whether it is CoreData, Realm, SQLite etc.

### Domain
The `Domain` is basically what is your App about and what it can do (`Entities`, `UseCase` etc.) It **does not depend on UIKit or any persistence framework**, and **it doesn't have implementations apart from entities**.

The recommended development order is from `Domain` to `Application`

## Detail overview

### Domain
`MBDomain/Entities` are implemented as Swift value types

```swift
public struct Question {
    public let id: Int
    public let title: String
    public let content: String
    public let created_at: String
    public let updated_at: String
}
```

`MBDomain/UseCases` are protocols which do one specific thing:

```swift

public protocol QuestionsUseCase {
    func questions() -> Observable<[Question]>
    func save(question: Question) -> Observable<Void>
}

```

`UseCaseProvider` is a [service locator](https://en.wikipedia.org/wiki/Service_locator_pattern).  In the current example, it helps to hide the concrete implementation of use cases.

### Platform
The `Platform` also contains concrete implementations of your use cases, repositories or any services that are defined in the `Domain`.

```swift
final class QuestionsUseCase<Cache>: MBDomain.QuestionsUseCase where Cache: AbstractCache, Cache.T == Question {
    private let network: QuestionsNetwork
    private let cache: Cache

    init(network: QuestionsNetwork, cache: Cache) {
        self.network = network
        self.cache = cache
    }

    func questions() -> Observable<[Question]> {
        let fetchQuestions = cache.fetchObjects().asObservable()
        let stored = network.fetchQuestions()
            .flatMap {
            return self.cache.save(objects: $0).asObservable().map(to:      [Question].self).concat(Observable.just($0))
        }

        return fetchQuestions.concat(stored)
    }

    func save(question: Question) -> Observable<Void> {
        return network.createQuestion(question: question).map { _ in }
    }
}
```
As you can see, concrete implementations are internal, because we don't want to expose our dependecies. The only thing that is exposed in the current example from the `Platform` is a concrete implementation of the `UseCaseProvider`.

```swift
public final class UseCaseProvider: MBDomain.UseCaseProvider {
    private let networkProvider: NetworkProvider

    public init() {
        networkProvider = NetworkProvider()
    }

    public func makeQuestionsUseCase() -> MBDomain.QuestionsUseCase {
        return QuestionsUseCase(network: networkProvider.makeQuestionsNetwork(), cache: Cache<Question>(path: "allQuestions"))
    }
}
```

### Application
In the current example, `Application` is implemented with the [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) pattern and heavy use of [RxSwift](https://github.com/ReactiveX/RxSwift), which makes binding very easy.

Where the `ViewModel` performs pure transformation of a user `Input` to the `Output`

```swift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
```
```swift
final class QuestionsViewModel: ViewModelType {
    struct Input {
        let trigger: Driver<Void>
        let createQuestionTrigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    struct Output {
        let fetching: Driver<Bool>
        let questions: Driver<[Question]>
        let createQuestion: Driver<Void>
        let selectedQuestion: Driver<Question>
        let error: Driver<Error>
    }

    private let useCase: AllQuestionsUseCase
    private let navigator: QuestionsNavigator

    init(useCase: AllQuestionsUseCase, navigator: QuestionsNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: Input) -> Output {
        ......
    }
```

A `ViewModel` can be injected into a `ViewController` via property injection or initializer. In the current example, this is done by `Navigator`.

```swift

protocol QuestionsNavigator {
    func toCreateQuestion()
    func toQuestion(_ question: Question)
    func toQuestions()
}

class DefaultQuestionsNavigator: QuestionsNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: ServiceLocator

    init(services: ServiceLocator,
        navigationController: UINavigationController,
        storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }

    func toQuestions() {
        let vc = storyBoard.instantiateViewController(ofType: QuestionsViewController.self)
        vc.viewModel = QuestionsViewModel(useCase: services.getAllQuestionsUseCase(),
        navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    ....
}

class QuestionsViewController: UIViewController {
    private let disposeBag = DisposeBag()

    var viewModel: QuestionsViewModel!

    ...
}
```
