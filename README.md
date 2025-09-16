# DicomMetaKit

A lightweight Swift package for reading **DICOM metadata** (tags, headers, attributes) without handling pixel data.  
Designed for educational, research, and utility purposes when only metadata inspection is required.

[(#DicomMetaKit (Korean))](https://github.com/bome24/DicomMetaKit?tab=readme-ov-file#dicommetakit-korean)

---

## ✨ Features
- Parse **DICOM Part 10** compliant files
- Extract metadata elements (Tag, VR, Value)
- Stop parsing at **Pixel Data (7FE0,0010)** by default
- Provide convenient helpers:
  - `string(for:)` for text-like VRs
  - `prettyLines()` for debugging/logging
- Lightweight, dependency-free, pure Swift

---

## 📦 Installation

### Swift Package Manager (SPM)
Add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/your-username/DicomMetaKit.git", from: "0.1.0")
]
```

Or in **Xcode**:
- `File > Add Package Dependencies…`
- Enter the repo URL
- Select your target

---

## 🚀 Usage

```swift
import DicomMetaKit

do {
    let url = URL(fileURLWithPath: "/path/to/sample.dcm")
    let dataset = try DicomMeta.read(url: url)

    // Access elements
    print(dataset.string(for: .patientName) ?? "(no name)")
    print(dataset.string(for: .studyDate) ?? "(no date)")
} catch {
    print("Failed to parse DICOM:", error)
}
```

---

## 🧪 Testing
Sample DICOM files can be placed under:

```
Tests/DicomMetaKitTests/Resources/
```

Example test:

```swift
@Test("Read sample DICOM")
func testReadSample() throws {
    let url = try #require(Bundle.module.url(forResource: "test_dicom_file", withExtension: "dcm"))
    let ds = try DicomMeta.read(url: url)
    #expect(ds[.transferSyntaxUID] != nil)
}
```

---

## ⚠️ Limitations
- **Pixel Data parsing is not supported.**  
- Only metadata is parsed; SQ/Item parsing is simplified.  
- Some uncommon Transfer Syntaxes may not be fully supported.  

---

## 📄 License
MIT License.  
Feel free to use, modify, and contribute.

---

# DicomMetaKit (Korean)

픽셀 데이터는 다루지 않고, **DICOM 메타데이터(Tag, 헤더, 속성)** 만을 읽기 위한 가벼운 Swift 패키지입니다.  
연구, 학습, 툴 제작 등 메타데이터 확인이 필요한 상황에 적합합니다.

---

## ✨ 특징
- **DICOM Part 10** 규격 지원
- 메타데이터 요소(Tag, VR, Value) 추출 가능
- 기본적으로 **Pixel Data (7FE0,0010)** 에서 파싱 중단
- 편의 기능 제공:
  - 텍스트 계열 VR → `string(for:)`
  - 디버깅/로그 출력 → `prettyLines()`
- Pure Swift, 외부 의존성 없음

---

## 📦 설치 방법

### Swift Package Manager (SPM)
`Package.swift`에 다음을 추가:

```swift
dependencies: [
    .package(url: "https://github.com/your-username/DicomMetaKit.git", from: "0.1.0")
]
```

또는 **Xcode**에서:
- `File > Add Package Dependencies…`
- 레포지토리 URL 입력
- 사용할 타겟 선택

---

## 🚀 사용 예시

```swift
import DicomMetaKit

do {
    let url = URL(fileURLWithPath: "/path/to/sample.dcm")
    let dataset = try DicomMeta.read(url: url)

    // 특정 태그 값 확인
    print(dataset.string(for: .patientName) ?? "(환자 이름 없음)")
    print(dataset.string(for: .studyDate) ?? "(검사 날짜 없음)")
} catch {
    print("DICOM 파싱 실패:", error)
}
```

---

## 🧪 테스트
샘플 DICOM 파일을 아래 경로에 추가하세요:

```
Tests/DicomMetaKitTests/Resources/
```

예시 테스트:

```swift
@Test("샘플 DICOM 읽기")
func testReadSample() throws {
    let url = try #require(Bundle.module.url(forResource: "test_dicom_file", withExtension: "dcm"))
    let ds = try DicomMeta.read(url: url)
    #expect(ds[.transferSyntaxUID] != nil)
}
```

---

## ⚠️ 제한 사항
- **Pixel Data 파싱은 지원하지 않습니다.**  
- 메타데이터 전용으로, SQ/Item 파싱은 단순화되어 있습니다.  
- 일부 드문 Transfer Syntax는 완전 지원되지 않을 수 있습니다.  

---

## 📄 라이선스
MIT License.  
자유롭게 사용/수정/기여할 수 있습니다.
