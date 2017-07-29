# 1주차

### 모게이

### 5인큐

##### Delegate
- 어떤 기능에 대한 구현이 다 되어있는데 그 기능을 실행하는데 일부 필요한 기능을 외부에 맡기는 것.
- 어떤 시점에 내가 그 메소드를 실행 해 줄 테니, 원하는 작업 있으면 구현 해라
- 요즘엔 클로저로 간편하게 구현해서 많이 쓴다.

##### 튜터링
- Dribbble 이라는 디자이너들이 UX 디자인 한 것을 업로드 하는 사이트가 있다. 여기서 3~5개 정도 만들어 보아라.
- 컬러 값 같은 경우에는 struct 모아서 쓰거나 extension 해서 쓴다.
- 순환 인덱스의 경우 나머지 연산자를 사용해라.???
- 변수 뒤에 타입 쓰는 것을 추천 (안써주면 컴파일러가 추론하는데 시간이 걸린다)
- 옵셔널 바인딩 한 변수를 이후에도 쓰려면 if-let 보다 guard-let 구문을 사용해라.
- 옵셔널 바인딩 시 여러가지 조건을 줄 시 조건 하나당 줄 바꿈을 해라.
- 클로져 등의 메모리 관리가 궁금하면 iOS와 OS X 메모리 관리와 멀티스레딩 기법 참고
- @escaping (탈출 클로저)는 꼭 비동기 작업에만 사용되는 것은 아니다.
클로저를 외부 변수에 넣거나 외부에서 쓰일 때 탈출 클로저로 만들어 주어야 한다.(@escaping 키워드를 붙여줘야)

### 다다

#### WWWDC - 타이포그라피

#### 오토레이아웃
- 특정위치에 고장돼서 튀어나왔다 사라지는 개념들, 모션이 주어지는 경우에는 57

#### Notification vs Delegate
- 델리게이트
  - 1:1
  - 델리게이트 계속 체인으로 연결되어 있는경우가 있다.
  - 이때 전달할때 오류가 날 수 있다.
- 노티피케이션은 다 알리는 개념.
  - 1: N 개념.
  - 델리게이트 없이도 다 알릴 수 있다.

#### 어플을 만들 때 데이터 스트럭쳐 (DB 스키마)를 먼저 잘 짜놓는게 좋다

#### 봉쥬르 에어드랍-같은와이파읶리묶여있으면!

### 쌍쌍바

#### * 지식은 존재 여부조차 모르는 것과 존재를 아는데 모르는 것 지식을 아는 것으로 나뉜다. 지식을 알기 위해 커뮤니티 활동을 하는 것도 추천한다.

---

# 2주차

##### 모게이
- 인사담당자에 메일을 보내면서 문을 두드리라(a4한장정도의 자기소개를 깔쌈하게 준비하자), 취업? 약빨고 두드리도록
- 명함을 만들자 (네트워킹 데이때 사용할 수 있게)
- 업계 네트워크를 활용하라 (meetup에 적극 참여)

- 객체지향 프로그래밍 -> 프로그래밍 페러다임, MVC -> 디자인패턴

- dynamic_dispatch -> 인스턴스에게 그때 물려준다.

##### 5인큐
- 접근자에 따라서 프로퍼티를 배치시키기.(public>privvate, var>let)
- 연산자는 무조건 공백을 두어서 사용
- 구글에서 swift coding guide 검색~
- weak은 리테인이 2번되는 것을 방지하기 위해서 사용한다.
- 소스트리의 스태시 항목을 사용하면 소스트리를 사용하는 불편함을 덜 수 있다.
- 클로저 캡처랑 관련된 문제 - self, [ unowned self ]

##### 쌍쌍바
- String += 컴파일러가 적절하게 처리하지 못해 컴파일 속도를 굉장히 느려지게 만듦. -> append사용
- 예시) 로그인이후의테스트a.setUp
- 로그인b.tearDown
- 로그아웃16.국내앱들은거의적용을안함... 적용난이도가어렵기때문에-능력과여유가생긴다면꼭적용해보자
- 오토레이아웃을이용해부모 View의비율로정하고싶다면,width, height에 multiply를...
- 디자이너의요구사항변경이잦은데, 스냅킷을이용하면처음에는만들기힘들어도대응하기는쉬워짐


# 4주차

### 모게이

- Commit단위와 메세지는 매우 중요합니다.

- 예를들어, 저장하는 모듈, 저장을 불러오는 모듈 등 커밋의 단위를 알맞게 설정하는 것은 중요합니다.

- 스토리 보드를 사용할 경우 conflict될 가능성이 매우 높으므로 하나의 main스토리보드에서 reference를 따서 각 각 수정하는것이 합리.

- controller 내 view에서 subviews로 @IBOutlet을 가지고 있기 때문에 weak을 해줌.


#### 포맷

type: subject

body

footer

#### type

feat: a new feature
fix: a bug fix
docs: changes to documentation
style: formatting, missing semi colons, etc; no code change
refactor: refactoring production code
test: adding tests, refactoring test; no production code change
chore: updating build tasks, package manager configs, etc; no production code change

#### 예시

feat: Summarize changes in around 50 characters or less

More detailed explanatory text, if necessary. Wrap it to about 72
characters or so. In some contexts, the first line is treated as the
subject of the commit and the rest of the text as the body. The
blank line separating the summary from the body is critical (unless
you omit the body entirely); various tools like `log`, `shortlog`
and `rebase` can get confused if you run the two together.

Explain the problem that this commit is solving. Focus on why you
are making this change as opposed to how (the code explains that).
Are there side effects or other unintuitive consequenses of this
change? Here's the place to explain them.

Further paragraphs come after blank lines.

- Bullet points are okay, too

- Typically a hyphen or asterisk is used for the bullet, preceded
by a single space, with blank lines in between, but conventions
vary here

If you use an issue tracker, put references to them at the bottom,
like this:

Resolves: #123
See also: #456, #789
