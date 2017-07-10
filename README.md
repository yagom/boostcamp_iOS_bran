## 1주차

### 학습

### 질문

---

## 2주차

#### 학습

###### MVC

###### FootTracker

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

###### 생각과제

- Why H.I.G?
    > you'll need to meet high expectations for quality and functionality. - H.I.G 발췌
    > Apple 에서 제공하는 Interface Guideline 을 지킴으로서 일관되고 완성도 있는 애플리케이션을 제작가능함.
    > 추가적으로 디자이너와 협업하는 과정에서 기본 가이드라인으로서 활용 가능.

### 질문
