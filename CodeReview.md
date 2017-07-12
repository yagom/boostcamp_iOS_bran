# 1주차

# 2주차

### Property to Controller
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

> 두개 이상의 If(분기)가 쓰인다면 정확한 디버깅을 제공.
> if문은 가독성 높게 사용 (!지양)
```swift
//if !password.isEmpty && !passwordCheck.isEmpty && password == passwordCheck {
if password.isEmpty == false &&
    passwordCheck.isEmpty == false &&
    password == passwordCheck {
    self.dismiss(animated: true, completion: nil)
    return
```

> UIResponder의 resignFirstResponder()는 기본적으로 true를 반환
```
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
-                let bikes = json?["GeoInfoBikeConvenientFacilitiesWGS"] as? [String: Any]
+                guard let json = (try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else { return }
```

// for문을 통한 interating을 하고 있다 에러발생시 return 보단 continue 고려 => 하나의 row가 어긋났을 수 있음.
```swift
for row in rows {
guard let latitude = row["LAT"] as? String,
let longitude = row["LNG"] as? String,
let address = row["ADDRESS"] as? String
//else { return }
    bikeStations.append((address, Double(latitude)!, Double(longitude)!))
    else { continue }

    if let lat = Double(latitude), let long = Double(longitude) {
    bikeStations.append((address, lat, long))
    }
}
```

> 프로퍼티에 적절한 접근권한 줘보기 open, public, internal, fileprivate, private 

> "string".image() -> "string".image like UIColor.blueColor() -> UIColor.blue

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

> 프로퍼티에 적절한 접근권한 줘보기 open, public, internal, fileprivate, private
