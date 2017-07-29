# 1주차

# 2주차

### 패턴

> 사용자가 이미지 피커를 여러 번 볼 수도 있다는 가정을 하면, 이미지 피커를 매 번 생성하지 않고, 프로퍼티로 활용.

```swift
    // 이미지 피커
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        return imagePickerController
    }()
```

> UIView의 endEditing(_:)
Causes the view (or one of its embedded text fields) to resign the first responder status.

> UIResponder의 resignFirstResponder()는 기본적으로 true를 반환

```swift
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //textField.resignFirstResponder()
    //return true
    return textField.resignFirstResponder()
}
```

> 옵셔널 강제 추출은 노노 (최고는 옵셔널 바인딩 그것도 guard(if보단)를 통해서)

```swift
//let url = URL(string: "http://openapi.seoul.go.kr:8088/5441567058796c6c36376c52437676/json/GeoInfoBikeConvenientFacilitiesWGS/1/100")
guard let url = URL(string: "http://openapi.seoul.go.kr:8088/5441567058796c6c36376c52437676/json/GeoInfoBikeConvenientFacilitiesWGS/1/100") else { return }
```
```swift
let json = try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
    let bikes = json?["GeoInfoBikeConvenientFacilitiesWGS"] as? [String: Any]
    guard let json = (try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else { return }
```


> for문을 통한 interating을 하고 있다 에러발생시 return 보단 continue 고려 => 하나의 row가 어긋났을 수 있음.

```swift
for row in rows {
    guard let latitude = row["LAT"] as? String,
        let longitude = row["LNG"] as? String,
        let address = row["ADDRESS"] as? String
        //else { return }
    else { continue }

    bikeStations.append((address, Double(latitude)!, Double(longitude)!))
    if let lat = Double(latitude), let long = Double(longitude) {
        bikeStations.append((address, lat, long))
    }
}
```

### 컨벤션
> 두개 이상의 If(분기)가 쓰인다면 정확한 디버깅을 제공.
> if문은 가독성 높게 사용 (!지양)
```swift
//if !password.isEmpty && !passwordCheck.isEmpty && password == passwordCheck {
if password.isEmpty == false &&
    passwordCheck.isEmpty == false &&
    password == passwordCheck {
    self.dismiss(animated: true, completion: nil)
    return
}
```

> "string".image() -> "string".image like UIColor.blueColor() -> UIColor.blue

### 기타

> 프로퍼티에 적절한 접근권한 줘보기 open, public, internal, fileprivate, private

> 하나의 프로그래밍코드 단위에 사용되는 변수는 위로위로

> Lazy 예약어의 적재적소의 활용, 프로퍼티의 쓰임새(목적, 성격)에 따라 생각해보기, [unowned self], 익명 메소드?클로저?바로 실행하기
```swift
//var locationManager: CLLocationManager!

private lazy var locationManager: CLLocationManager = {
    [unowned self] in

    let manager = CLLocationManager()
    manager.delegate = self    

    return manager
}()
```

# 3주차

### 패턴

> 실수를 줄이려면 하드코딩 보다는 구조화된 타입을 사용

```swift
NotificationCenter.default.post(name: Notification.Name.init("TouchUpInside"), object: self)
````

```swift
    NotificationCenter.default.post(name: EventNotification.Touch.upInside, object: self)

    private struct EventNotification {
        struct Touch {
            static let upInside = Notification.Name(rawValue: "TouchUpInside")
            static let upOutside = Notification.Name(rawValue: "TouchUpOutside")
            static let down = Notification.Name(rawValue: "TouchDown")
        }
    }
```

> ARC

> 클로저에서도 순환참조가 이루어 질 수 있으므로

> weak, unowned 해야하는데 내가 절대 사라질 일이 없으면 unowned(weak이 nil값을 가질 수 있는 것과 차이를 둠)

# 4주차

### 패턴

> 프로퍼티는 프로퍼티 대로, 메서드는 메서드대로, 접근수준에 따라 분류.

> Extension을 통해 기능별로 묶는 습관 -> cocoa touch framework 참고

> 클로저를 통하여 UI컴포넌트의 생성과 동시에 컴포넌트의 프로퍼티를 설정 & viewDidLoad일대 초기화값을 가지는 UI컴포넌트를 addSubView

```swift
    private lazy var closeButton: UIButton = { [unowned self] in
        let closeButton = UIButton()
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = UIColor.red
        closeButton.titleLabel?.font = closeButton.titleLabel?.font.withSize(20)
        closeButton.addTarget(self, action: #selector(RecordsViewController.showMainView(_:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(RecordsViewController.dismissView(_:)), for: .touchUpInside)
        return closeButton
    }()
```

### 기타

> * 주석처리할 코드들은 commit 하지 않는게 좋습니다. 주석으로 남겨두려면 남긴 이유에 대한 명확한 설명이 있다면 좋습니다.

> 주석 대신에 commit 메세지들로 변경된 코드의 내용을 명확히 설명하는 것이 더욱 좋겠습니다. */

> 프로퍼티나 메소드를 정의할 때는 접근수준을 고려하자!

> 데이터를 기반으로한 UI들은 다른화면에서 데이터에 변화가 일어날 것을 고려한 코딩을 하자.

> guard 문을 감싸 return 을 할때는 그값이 nil일 경우 필요한 요소(nil일 때 00:00:00을 찍어야한다)를 고려.
