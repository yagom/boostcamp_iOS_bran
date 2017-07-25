# 4주차

### 질문

TimeInterval로 프로퍼티를 줄 때, Double로 프로퍼티를 줄 때 decode가 안되는 듯.

교재 13장에서 IBOutlet을 strong으로 주는데 특별한 이유가 있는지.
기존에 IB에서 만든 subView들은 superView를 가지고 있으므로 weak으로 해주는 것으로 알고 있었음.
사라졌다가 다시 만들 필요가 있을 때 strong으로 알고 있어도 되는지.

### 생각해보기

#### Archive

- 아카이브 가능한 클래스

    - NSObject의 서브클래스만 NSCoding프로토콜 준수 가능
    - encode(with aCoder: NSCoder)에서 저장할 데이터(프로퍼티)를 특정 Key를 통해 저장한다.
    - public required init?(coder aDecoder: NSCoder)에서 특정 Key를 통해 값(데이터)를 가져온다.
    - 아카이브 될 데이터(프로퍼티)들 역시 NSCoding 준수해야함
    - Int, Double같은 경우는 특정 메서드(오브젝트x)로 디코드해야함.
    - 코코아 클래스들 많은 것들이 NSCoding 을 따르고 있다. (특히 UIView, UIViewController 까지)

- 다큐먼트 폴더

    - FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    - 파일 매니저를 통한 접근 (or NSSearchPathForDirectoriesInDomain)
    - 해당 폴더에 접근 후 특정 파일명을 붙여서 아카이브 장소 Path를 설정한다.
    
- 데이터 아카이브

    - NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path)
    - NSKeyedArchiver.archiveRootObject(self.records, toFile: archiveURL.path)
    - 사용자의 데이터는 애플리케이션 Life Cycle을 고려하여 자주 저장해줘야함.
    - 종료될 때, 백그라운드로 들어갈 때, 새로운 데이터를 만들 때, 데이터를 수정할 때 등을 고려할 필요있음.

#### Custom Transition

- UIStoryboardSegue

    - Segue 와 unwind Segue
    - 해당 Segue를 가진 Controller에서 unwind Segue @IBAction도 함께 가지고 있어야함.
    - InterfaceBuilder에서 하면 해당 Class를 입력해주면 해결

- UIViewControllerAnimatedTransitioning

    - present 와 dismiss
    - Present, Dimiss될 때 Transion이 적용될 Controller에게 TransioningDelegate를 준다.
    - forPresent, forDimiss메서드를 오버라이드해서 알맞은 AnimatedTransitioning 인스턴스를 반환.

#### Animation

### 한번 더 생각해보기

- TableView나 CollectionView에서 Cell을 삭제할 때 DataSource의 값에서 실제 값을 제거 후 Deleterow(item)을 호출하자.

- 컨텐트 크기 유지 우선순위 -> 높을 수록 자신의 크기를 유지하려는 정도가 강함.

- 세그웨이를 통해 뷰 컨트롤러간 상호작용을 설정할 수 있다.

- 네비게이션 컨트롤러(뷰 컨트롤러간 역관이 있을 경우)를 활용할 때 루트 뷰 컨트롤러에서 모든 데이터를 가지고 있고, 데이터의 일부를 다음 뷰 컨트롤러에 전달하는 것이 깔끔하고 효율적임.

- 세그웨이를 통한다면, prepare를 통해 다음 컨트롤러에게 데이터 전달하기.

- view에서 endEditing(_:) 호출은 계층 구조의 어느 텍스트 필드가 퍼스트 리스폰더인지 확인 후 그 뷰.resignFirstResponder() 함.

