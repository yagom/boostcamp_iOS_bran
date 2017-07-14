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

### 질문

