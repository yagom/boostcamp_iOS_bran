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

- hash 값이 중복?

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

- GestureRecognizer는 cumulative 하지 않는다 -> 같은 제스쳐는 마지막으로 넣어준 target-action적용.
A gesture recognizer has one or more target-action pairs associated with it. If there are multiple target-action pairs, they are discrete, and not cumulative. Recognition of a gesture results in the dispatch of an action message to a target for each of the associated pairs. The action methods invoked must conform to one of the following signatures:

- stored property는 초기값을 넣어주던가, initializer에서 초기화를 해줘야만 한한다.
- 하지만 이때는 property observers를 부르지 않는다 -> didSet 안불림.
- 트릭으로 defer를 한번더 불러줄 수 있지만 좀 더 세심한 코딩이 필요할 듯 함.
- defer는 에러핸들링이나 condition에 따라 코드 실행순서 달라지는 상관없이 블락이 벗어날때 한번더 실행되는 것.
> When you assign a default value to a stored property, or set ints initial value within an initializer, vthe value of that property is set directly, without calling any property observers.

- Extension을 활용하면 init을 받아오면서 새로 init을 정의할 수 있습니다~
