# 1주차

### 질문

---

# 2주차

### 질문

- Supporting Multiple Versions of iOS, 예전엔 Class의 존재여부로, 지금은 #available로 맞나?

> A: swift로 코딩할 경우 available키워드를 통해 분기사용

- UIApplication에서 값을 저장 삭제할때 프로퍼티로? 아니면 어떤방식으로? background할때

> A: ViewController가 가지고 있는 메서드 활용 encodeRestorableStateWithCoder:

- (Required) Assign restoration identifiers to the view controllers whose configuration you want to preserve; see Tagging View Controllers for Preservation.
- (Required) Tell iOS how to create or locate new view controller objects at launch time; see Restoring View Controllers at Launch Time.
- (Optional) For each view controller, store any specific configuration data needed to return that view controller to its original configuration; see Encoding and Decoding Your View Controller’s State.

```swift
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
[super encodeRestorableStateWithCoder:coder];

[coder encodeInt:self.number forKey:MyViewControllerNumber];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
[super decodeRestorableStateWithCoder:coder];

self.number = [coder decodeIntForKey:MyViewControllerNumber];
}
```

자세한건 [State Restoration](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/PreservingandRestoringState.html#//apple_ref/doc/uid/TP40007457-CH28-SW6) 읽기


###### 교재 4~6장 문제 해결해보기
- TextField
  Delegate를 통해 TextField 텍스트 변화 추적

- CharacterSet

  - 캐릭터가 범위 안에 갖도록 하기.
```swift
  var numberCharacters = CharacterSet()
  numberCharacters.formUnion(CharacterSet.decimalDigits)
  numberCharacters.insert(charactersIn: ".")
  if string.rangeOfCharacter(from: numberCharacters) == nil, string != "" {
    return false
  }
```

  - URLString에서 알맞은 형식으로 변환할 때
  ```swift
    "url".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)
  ```

- CLLocationManager: The central class for configuring the delivery of location-related events to your app.

  - Call the authorizationStatus()

  - Create your CLLocationManager object and assign a delegate to it.

  - In iOS, if the authorization status was notDetermined, call the requestWhenInUseAuthorization() or requestAlwaysAuthorization() method to request the appropriate type of authorization from the user.

  - locationServicesEnabled(): If you use the standard location service, call the locationServicesEnabled() method.

  - significantLocationChangeMonitoringAvailable(): If you use the significant location-change service, call the significantLocationChangeMonitoringAvailable() method.

  - headingAvailable(): If you use heading information, call the headingAvailable() method.

  - isMonitoringAvailable(for:): If you monitor geographic or beacon regions, call the isMonitoringAvailable(for:) method.

  - isRangingAvailable(): If you perform ranging on Bluetooth beacons, call the isRangingAvailable()

###### Start Developing iOS Apps (Swift)

- Initializer

    > SubClass는 기본적으로 SuperClass의 Initializer를 상속

    > SubClass가 하나라도 Override를 하면 SuperClass의 Initialzer 상속 X

    > SuperClass는 꼭 필요한 Initialzer를 Required로 표시가능

    > failable and nonfailable initializers

- AutoLayout

    > StackView에 들어가는 View들은 자동적으로 translatesAutoresizingMaskIntoConstraints = false

    > 하지만 습관적으로 AutoLayout을 사용하는 View는 명시적으로 false 설정해주자.

- @IBDesignable, IBInspectable

    > @IBDesignable : Once the build completes, the storyboard shows a live view of your custom view.

    > @IBInspectable : You can also specify properties that can then be set in the Attributes inspector.

    > @IBDesignable, IBInspectable 는 디자인을 디버그 하기 좋은 방안이 된다. -> 디자이너와 일하기 좋을 듯

    - Bundle Class 와 traitCollection 에 대해 알아보기.

- Accessibility 에서 label, hint, value 에 대해서 공부하기.

- Unit Test 사용

###### 교재의 UIGestureRecognizer(18장)

- UIMenuItem

  > 프로그램당 하나만 존재가능? <- singleton으로 구현된듯 <- Window의 First Responder에 보내지는 메시지 라고 하네.

  > 중요: UIMenuController의 메뉴 아이템 중 적어도 하나의 액션 메시지에 응답하는 뷰는 반드시 윈도우의 퍼스트 리스폰더여야 한다. ex) 해당View.becomeFirstResponder()

  > If CustomView canBecomeFirstResponder() 메서드 오버라이딩

###### LoginPage

- UIDeviceOrientation 에 따른 Layout 변경

    > Develop Info 에서 Orientation 설정 -> 이것이 어디에 영향을 미치는지?

    > ViewCotroller 내에 있는 프로퍼티 오버라이드.

    > 거꾸로 했을 때 PickerController 위에서 내려옴?

```swift
  override open var shouldAutorotate: Bool {
    return true
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    get {
      return UIInterfaceOrientationMask.all
    }
  }

  override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
    return .portrait
  }
```

### 질문

- FoG에서 나타난 디자인 패턴을 익히고 각 용도및 장점을 파악, 내 코드에 써먹을 수 있도록.

- Supporting Multiple Versions of iOS
    - 예전엔 Class의 존재여부로, 지금은 #available로 맞나?
    > A: swift로 코딩할 경우 

- 프로퍼티를 암시적 추출 옵셔널로 생성해 위 메소드에서 초기화하는 전략이 최고?

- fileprivate, private

- UIApplication에서 값을 저장 삭제할때 프로퍼티로? 아니면 어떤방식으로? willterminate할때

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

- unowned self, tableView vs unowned self, unowned tableView

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

# 목요일 튜터링

- 프로세스, 멀티테스킹, 멀티 코어, 멀티 스레드

- background 진입시 유의 해야할 것들이 무엇인지 잘

- App LifeCycle을 Delegate와 NotificationCenter등록을 통해서 받아 볼 수 있다.

