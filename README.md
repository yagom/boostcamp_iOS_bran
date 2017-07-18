# 3주차

### 질문

- 의존 관계 역전 (dependency inversion principle), cf) SOLID
store(추상, 저수준)이 controller(고수준) 밖으로 나옴

- tableView.contentInset 이 스크롤 위로 올려도 안보여야하는게 아닌지

- image literal 사용

- notification으로 받으면 Notification 인자로 넘어오는데?
> @IBAction func doSomething()
> @IBAction func doSomething(sender: UIButton)
> @IBAction func doSomething(sender: UIButton, forEvent event: UIEvent)

### 생각해보기

#### UIButton

1. addTarget으로 중복되는 것은 안됨 <- UIControl에서 allTargets를 Set으로 관리중?

1-2. self와 nil을 주면 action이 두개다 실행 <- maybe nil일 경우는 추적해서 실행하므로 중복검사 안하는듯

2. But 다른 Event에 등록해주면 중복이 됨.

3. target에 nil로 하면 UIKit이 자동으로 action이 있는 object를 찾아 실행함

4. target은 object를 retain하지 않으므로 그 전단계에서 꽉 잡고 잇어야함.

- Q. 이것을 실험하고 싶은데 nil을 넣어도 계속 불리게 됨. -> autoreleasepool이 불리는 시점? 강제 불리?

#### UIControl

- targets, actions, events들의 관계를 어떻게 저장하고 구분할까? Dictionary?

#### Custom Button View

- UIResponder의 Subclass들은 touches***를 지니고 있음.

- 해당 View에 GestureRecognzier를 등록해서 해당 이벤트에 action 실행

- 해당 View에 touches메서드를 Override해서 적절하게 호출

- UIControl의 특정 target과 controlEvent에 알맞은 action을 찾는 방법은 무엇일까?

> The target object—that is, the object whose action method is called. If you specify nil, UIKit searches the responder chain for an object that responds to the specified action message and delivers the message to that object.

- UIControl을 상속받은 애들은 UIKit이 매치되는 object를 찾아서 실행시켜줌 (묵시적)

### 한번 더 생각해보기

- Cell이 변형가능한 height를 통해 accessibility를 지원하게 됨.

- tableView.rowHeight -> UITableViewAutomaticDimension(default),
    tableView.estimatedRowHeight -> 0(default), 값을 입력하면 추측하는데 도움을 줌, 값안주면 autoLayoutCell이 안됨.

- body를 통해 font Size 사용자화에 맞추기.

- private 접근자는 objc에 없기때문에 Selector로 private을 넘기려면 @objc를 붙여야함.
