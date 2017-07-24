# 4주차

### 질문

TimeInterval로 프로퍼티를 줄 때, Double로 프로퍼티를 줄 때 decode가 안되는 듯.

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

-TableView나 CollectionView에서 Cell을 삭제할 때 DataSource의 값에서 실제 값을 제거 후 Deleterow(item)을 호출하자.
