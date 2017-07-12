# 1주차

### 학습

### 질문

---

# 2주차

### 학습

##### MVC

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


###### 생각과제

- Why H.I.G?
    > you'll need to meet high expectations for quality and functionality. - H.I.G 발췌
    > Apple 에서 제공하는 Interface Guideline 을 지킴으로서 일관되고 완성도 있는 애플리케이션을 제작가능함.
    > 추가적으로 디자이너와 협업하는 과정에서 기본 가이드라인으로서 활용 가능.

### 질문

- FoG에서 나타난 디자인 패턴을 익히고 각 용도및 장점을 파악, 내 코드에 써먹을 수 있도록.
