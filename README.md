# crop-disease-diagnosis-service

crop disease diagnosis service application with image-captioning and object-detection(deep learning)

* github : https://github.com/DI-LEE/crop-disease-diagnosis-service

# Contents

1. [Team](#team)
   - [Team Organization](#team-organization)
2. [Requirement](#requirements)
   - [APP frontend environment for build](#app-frontend-environment-for-build)
   - [Train Environment](#train-environment)
3. [Keywords](#keywords)
4. [Motivation & Purpose](#motivation--purpose)
5. [Goals](#goals)
6. [System Structure](#system-structure)
7. [Service Flow](#service-flow)
8. [Disease Diagnostic Results](#disease-diagnostic-results)
   - [Result Screen](#result-screen)
   - [Result Video](#result-video)
9. [Project Flow](#project-flow)
10. [Deep Learning](#deep-learning)
    - [Data Collection and Labeling](#data-collection-and-labeling)
    - [Modeling](#modeling)
11. [App](#app)
    - [Frontend](#frontend)
    - [Backend & Server](#backend--server)
12. [Benefits](#benefits)
13. [References](#references)


## :seedling:내 손안의 식물의사: 닥터 쑥쑥

> **딥러닝 기반 이미지 캡셔닝과 객체 인식을 이용한 작물 질병 진단 서비스**

- [한국데이터산업진흥원](https://www.kdata.or.kr/) [데이터청년캠퍼스](https://dataonair.or.kr/bigjob/) 한국외국어대학교 과정

![한국데이터산업진흥원외대로고리사이즈](https://user-images.githubusercontent.com/79498819/188061047-dfe7f2ea-3d98-401f-b3c4-ba0ac0a5707c.gif)

# Getting Start

1. apk download : https://github.com/DI-LEE/crop-disease-diagnosis-service/releases
2. 설정 -> 생체 인식 및 보안 -> 출처를 알 수 없는 앱 설치 -> 내 파일 선택 후 허용 -> 내 파일 -> apk 선택 후 `Dr.쑥쑥 `앱 설치

> For detail instructions :  [Service Flow](#service-flow)

# Team

## Team Logo

돋을볕

![image](https://user-images.githubusercontent.com/79498819/188061141-5a6e6634-f267-4133-bce1-dd050f458956.png)

## Team Organization

|    Name    |                             role                             |       Contact        |
| :--------: | :----------------------------------------------------------: | :------------------: |
| **이동인** | 팀장, 이미지캡셔닝 모델 구축 및 이식, 백엔드 서버 구축 보조, 시스템 구조 설계 |  dongeen1@gmail.com  |
|   장승호   | 오브젝트 디텍션 모델 구축 및 데이터 증강, 앱 서비스 플로우 제작 | jason9865@naver.com  |
|   이지환   | 이미지 캡셔닝 모델 구축 및 모델 성능 비교연구, 앱 서비스 플로우 제작 |  ywl9845@naver.com   |
|   류승기   | 백엔드 로직 설계 및 구축, 프론트엔드 백엔드 간 통신 및 연결, 서버 구축 및 모델 이식 | ysg980423@gmail.com  |
|   정훈서   | 오브젝트 디텍션 모델 구축 및 이식, 백엔드 서버 구축 보조, 시스템 구조 설계 | joel39809@gmail.com  |
|   오지환   |              데이터 수집 및 분석, 기획 및 발표               |  kmm8777@naver.com   |
|   양건안   | 프론트엔드 로직 설계 및 구축, 프론트엔드 백엔드 간 통신 및 연결, UX/UI 디자인 | moho191113@gmail.com |
|   김재원   |                         기획 및 발표                         | handaijen@gmail.com  |

# Requirements

### Image-Captioning Requirements for train

```
cd requirements
pip install -r img_cpt_requirements.txt  # install
```

#### key requirements

* `python==3.9`
* `tensorflow-gpu==2.8.0`

### Object-detection Requirements for train

```
cd requirements
pip install -r ob_requirements.txt  # install
```

#### key requirements

* `torch==1.12.1`

### APP

#### frontend Requirements

```
cd app_front
flutter pub get  # install
```

#### backend Requirements

```
cd requirements
pip install -r backend_requirements.txt  # install
```

#### key requirements

* `flutter==3.0.5 `
* `flask==2.2.2`

## APP frontend environment for build

* `flutter==3.0.5`
  * https://docs.flutter.dev/get-started/install/windows

* `Android Studio (version 2021.2)`

  * https://developer.android.com/studio?gclid=Cj0KCQjwjbyYBhCdARIsAArC6LJMRjRYK3GoWMjxbVMacicwuMD_e8fC7eFfgLeR94UWBFInFOO5PWQaAhn0EALw_wcB&gclsrc=aw.ds
  * Android SDK Platform
    * `Android API 33`

  * Android SDK Tools

    *  `Android SDK Build-Tools 33`
    *  `Android SDK Command-line Tools`

  * Android Emulator spec

    * Pixel XL
    * RAM : 5000
    * VM heap : 1000
    * Internel Storage : 5000

  * Additional setting (build 시 sound null 오류 해결)

    * terminal 에서 build : 옵션 `--no-sound-null-safety` 추가
* GUI 에서 build : Android Studio -> Run -> Edit Configurations -> Additional run args -> `--no-sound-null-safety` -> apply

## Train environment

* `RTX 2070`
* `CUDA Version==11.2`
* `cudnn==7.6.5`

# Keywords

* Image-captioning
* Object-detection
* Natural Language Generation
* Diagnosis of crop disease
* Home farming

# Motivation & Purpose

 도시농업에 대한 관심도가 매년 꾸준히 증가하고 있다. [서울시 제공 자료]( https://cityfarmer.seoul.go.kr/brd/view.do?key=1905228807693&nttSn=6082 )에 따르면 도시농부 수는 2010년 15만명에서 2020년 185만명으로 10년 만에 10배나 증가했다. 특히 최근 물가상승의 여파로 식자재값이 급등하여 농작물을 구매하지 않고 직접 집에서 키워 섭취하는 ‘홈파밍’ 문화가 확산되고 있다. 이처럼 도시의 가정에서 직접 작물을 길러 소비하는 도시농업 시장이 꾸준히 증가하고 있지만, 도시농부들은 대체로 전문 농업인이 아닌 새내기 농부가 많아 영농기술 및 농업 경험 부족으로 농작물의 질병을 제때 진단하지 못해 적절한 치료법으로 작물을 관리하지 못하고 결국 수확에 실패한 사례를 어렵지 않게 찾아볼 수 있다. **따라서 도시농부의 작물 관리를 돕기 위해 작물의 상태를 자세하게 묘사하고 해당 질병을 진단하는 앱 서비스를 개발하게 되었다.**

# Goals

 도시농부 등 농업에 익숙하지 않은 **초보 농부**를 대상으로 한 작물 관리 앱을 개발하고자 했다. 질병에 감염된 것으로 의심되는 작물의 사진을 찍으면 인공지능 딥러닝 기술 기반의 모델을 거쳐 **감염 환부를 바운딩 박스로 표시하고 환부에 대한 자세한 묘사와 함께 해당 질병을 진단하는 문장을 생성**하도록 했다. 단순히 어떤 질병에 걸렸는지만 알려주는 것이 아니라 질병 감염 부위를 표시하고 감염 부위를 자세하게 묘사하여 질병 진단에 대한 명확한 근거를 제시할 수 있다. 또한 질병 자체를 진단함으로써 해당 질병에 감염될 수 있는 모든 작물에 대한 질병 진단을 가능하게 하여 작물별로 병을 진단하는 번거로움을 해소할 수 있도록 했다. 또한 진단의 정확도를 높이기 위해 정상적인 상태의 작물 사진이나 작물이 아닌 물체의 사진을 입력했을 때 질병이 진단되지 않도록 추가 데이터를 구축하여 모델을 학습시켰다. 감염된 작물의 질병이 진단되면 해당 질병의 발생 환경과 관리법을 소개하여 질병을 치료하고 예방하는 방법을 쉽게 알려주도록 했다.

# System Structure

![image01](https://user-images.githubusercontent.com/79498819/187089936-ba228c58-8ce3-4b16-90d5-0c24486f8db9.png)


# Service Flow

 ![image02](https://user-images.githubusercontent.com/79498819/187089950-e65cf190-7c8c-419e-b19c-5fd9fa26903a.png)

# Disease diagnostic results

## result screen

![image03](https://user-images.githubusercontent.com/79498819/187089977-b11bf678-b958-42c0-b732-a9dd111652b6.png)

## result video


https://user-images.githubusercontent.com/79498819/187265541-43766edb-f1fb-462d-9100-8bad7cbd4986.mp4


# Project Flow

![image04](https://user-images.githubusercontent.com/79498819/187089985-d92a5ede-9499-4953-8d5c-bec32b1c17cc.png)

# Deep Learning

## Data Collection and Labeling

 작물 이미지 데이터로는 [AI-hub](https://www.aihub.or.kr/)에 오픈소스로 공개되어 있는 ‘노지작물 질병 진단 이미지’와 '시설 작물 질병 진단 이미지' 데이터셋을 사용했다. 해당 이미지 데이터셋에는 정상적인 작물 이미지와 질병에 걸린 작물 이미지가 골고루 들어있어 학습용 데이터로 적합하다는 판단을 내렸다. 전체 이미지 데이터셋에서 ‘고추’, ‘애호박’, ‘토마토’, ‘콩’, ‘파’ 등 총 **5개의 작물**을 선별한 이미지 데이터를 추출하여 **총 9개의 질병**을 탐지하고자 했다. 또한 각 질병의 특징과 중증도를 구분하여 질병의 특징을 묘사하는 캡션 문장 데이터를 구축했다. 이미지 캡셔닝 모델 학습에는 **총 123,913개의 이미지와 619,565개의 캡션**을 사용했으며 오브젝트 디텍션 모델 학습에는 **총 31,394개의 이미지**를 사용했다.

## Dataset

### 이미지 캡셔닝(Image Captioning) 데이터셋 및 모델 weight

Dataset and Weight Download : https://drive.google.com/drive/folders/1nT2tOmWdmjItQA_5MNHqByVcMas0bzKp?usp=sharing

|        |  Train  | Validation |
| :----: | :-----: | :--------: |
| Images | 123,913 |    303     |
| Label  | 619,565 |   1,515    |

### 오브젝트 디텍션(Object Detection) 데이터셋 및 모델 weight

Dataset and Weight Download :https://drive.google.com/drive/folders/1NmlqqYI_ePEpUEhjWU2qUO5R1MMMHy-L?usp=sharing

|  원천  | Train | Validation |
| :----: | :---: | :--------: |
| Images | 4,871 |   1,099    |

|  증강  | Train  | Validation |
| :----: | :----: | :--------: |
| Images | 20,587 |   4,837    |

| Total  |  Train  | Validation |
| :----: | :-----: | :--------: |
| Images | 25,458  |   5,936    |
| Label  | 144,172 |   33,717   |

## Data Labeling

### 이미지 캡셔닝(Image Captioning) 라벨링 기준

#### 1. AI-hub에 수록되어 있는 메타데이터를 활용

- 이미지의 메타데이터는 json 형태로 저장되어있음
- 메타데이터중 ‘학습용 정보(annotations)’ 를 참고함
  - **질병/해충 코드(disease)**로 질병의 종류를 파악
  - **작물코드(crop)**로 작물의 종류를 파악
  - **질병 피해 정도(risk)**로 질병의 피해 정도를 파악
- json 파일의 annotations 부분이 이미지의 제목에 반영되어 있음을 확인

**<이미지>**

![고추이미지와이름](https://user-images.githubusercontent.com/79498819/187622430-71f3c936-22de-4ce0-b880-fd80dc9319b2.jpg)

**<json 형식의 이미지 메타데이터>**

![고추어노테이션](https://user-images.githubusercontent.com/79498819/187622474-bbfe753d-edfa-4204-9ab3-632a3baed899.jpg)

**<AI-hub에 수록된 이미지 메타데이터 정보>**

![에이아이허브메타데이터](https://user-images.githubusercontent.com/79498819/187622412-59d18417-9831-42fb-8e83-d12ed4b1d294.jpg)

#### 2. ‘국가농작물병해충관리시스템’에서 제공하는 질병 키워드를 활용

- ‘**[국가농작물병해충관리시스템](https://ncpms.rda.go.kr/npms/Main.np)**’ 홈페이지의 ‘병해충정보’→’병해충별 도감정보’ 이동
- 질병을 검색하면 해당 질병에 걸릴 수 있는 작물의 종류와 해당 질병의 특징을 파악할 수 있음
- '증상 설명' 부분에서 질병의 특징을 나타내는 키워드를 파악할 수 있음
  - 가령, 고추 탄저병에서는 **원형반점, 담황색 내지 황갈색의 포자덩어리, 말라 비틀어짐**의 키워드를 파악할 수 있음

#### 3. 위의 두 데이터를 활용하여 작물의 질병을 진단하는 캡션 생성

#### 1) 질병 피해 정도를 측정

- **초기, 중기, 말기**로 나눠 라벨링 진행

#### 2) 질병 피해 정도에 따른 키워드 할당

- 질병 피해 정도에 따라 적용되는 키워드의 종류 및 개수가 서로 다름
  - Ex) 고추탄저병 
    - 초기: 원형 반점 
    - 중기: 원형 반점 + 황갈색(담황색)의 포자 
    - 말기: 원형 반점 + 황갈색(담황색)의 포자 + 말라비틀어짐

#### 3) 키워드를 활용한 캡션 문장 생성

- **작물 종류, 질병 종류, 질병 피해정도,** 그리고 **키워드**를 활용하여 **캡션 문장 생성**
  - Ex) 고추탄저병 
    - 초기: 고추에 원형 반점이 나타나 고추탄저병으로 의심됩니다 
    - 중기: 고추에 황갈색의 포자와 원형 반점이 생긴 것으로 보아 고추탄저병으로 의심됩니다
    - 말기: 고추에 원형 반점이 나타나고 황갈색이 포자가 보이며 말라 비틀어진 것을 보아 고추탄저병으로 의심됩니다
- 모델이 **다양한 문맥을 학습**할 수 있도록 **같은 의미의 서로 다른 문장을 생성**함
  - 어순 바꾸기
    - 상대적으로 어순이 자유로운 한국어의 특성을 활용하여 문장 성분의 순서를 바꾸며 여러 형태의 문장을 생성
  - 텍스트 역번역(Back Translation)
    - 네이버 '파파고' 기계번역기를 활용하여 문장을 외국어로 번역한 후 다시 한국어로 번역
    - '한국어→영어→일본어→한국어' 순서로 번역하여 기존의 문장과는 다른 형태의 새로운 문장을 생성

### 오브젝트 디텍션(Object Detection) 라벨링 기준

이미지 캡셔닝과 마찬가지로 AI-hub에 수록되어 있는 메타데이터의 '학습용 정보(annotations)'를 활용하여 작물의 이름과 질병의 종류를 파악한 후 bounding box 처리를 해주었다. 이 때 bounding box는 전체 작물 중 병변이 발생한 특정 부분에 표시를 해주었으며, 질병이 작물 전체적으로 퍼져있는 경우 부분이 아닌 작물 전체에 bounding box처리를 해주었다.

![187653219-083cef9d-f4db-4e69-9a1b-755228aa0d75](https://user-images.githubusercontent.com/79498819/187656858-02e6f21e-9345-46a1-8691-2de734f9e02d.jpg)

![187653281-6f922bc7-37f8-46f6-9f29-ef55051d61d4](https://user-images.githubusercontent.com/79498819/187656880-ca9f5f53-8d94-4b99-bbc1-5b677a266114.jpg)

## Modeling

### Used Model

* InceptionV3 + Transformer

  * 훈련 파일 경로: image-captioning/image_captioning_InceptionV3_Transformer.ipynb


* yoloV5m

### Image Captioning

**이미지 캡셔닝(Image Captioning)은 이미지를 설명하는 문장을 생성하는 기술**로, 이미지의 여러 가지 특징을 자세히 묘사한 문장을 생성한다. 프로젝트에 사용된 이미지 캡셔닝 모델은 자연어처리의 기계번역 매커니즘 중 하나인 **인코더-디코더 형식**을 사용한다. **인코더에서 이미지의 특징을 추출하고 디코더에서는 인코더에서 추출된 특징을 바탕으로 캡션 문장을 생성**한다. 우리의 이미지 캡셔닝 모델의 인코더에는 이미지 처리에 자주 사용되는 CNN 모델을 사용하는데 그중 ‘ImageNet’이라는 이미지 데이터로 사전학습을 거친 **InceptionV3 모델**을 사용했다. 그리고 디코더에는 자연어를 생성해내는 **언어 모델(Language Model)**을 사용하는데 대표적인 언어 모델로 **Attention모델과 Transformer 모델**이 있다. Attention 모델은 문장 구성 요소 중 특정 단어에 집중하도록 하는 알고리즘이 추가된 RNN 계열의 문장 생성 모델이며 Transformer 모델은 Attention 모델을 보완한 것으로, RNN 모델을 사용하지 않고도 여러 번의 ‘Self-Attention’ 방식으로 문장 생성 성능과 속도를 획기적으로 향상시킨 모델이다. **본 프로젝트의 이미지 캡셔닝 모델 디코더에 두 모델 중 문장 생성 성능이 더 높은 모델을 사용하기 위해 BLEU 스코어를 이용하여 두 모델의 문장 생성 성능을 비교했다.** 

  **BLEU 스코어**는 인간이 생성한 문장과 모델이 생성한 문장의 유사성을 수학적으로 계산하여 점수로 나타내는 대표적인 문장 생성 성능 지표로 기계번역 등에서 자주 이용된다. 문장 생성 성능이 좋을수록 높은 점수가 산출된다. 각 문장의 구성요소를 토큰으로 나누고 토큰을 비교하여 두 문장이 서로 공유하는 토큰의 개수 등을 수학적으로 계산하여 점수를 환산하는데, 토큰을 비교할 때 n-gram 기법을 적용하여 토큰 쌍을 비교할 수 있고 각 n-gram을 적용한 BLEU 스코어는 ‘BLEU_N’으로 표현된다. 본 프로젝트에서는 1-gram, 2-gram, 3-gram, 4-gram이 각각 적용된 **BLEU_1, BLEU_2, BLEU_3, BLEU_4,** 그리고 이 네가지 BLEU 스코어의 평균값인 **BLEU_AVG**를 이용하여 두 모델의 문장 생성 성능을 비교했다. Validation 데이터 셋을 이용하여 BLEU 스코어를 산출한 결과, BLEU_3을 제외한 나머지 BLEU 스코어에 대해 **Transformer 모델의 BLEU 스코어가 더 높았다.** 즉, Attention 모델보다 Transformer 모델의 문장 생성 성능이 더 좋았기 때문에 본 프로젝트의 이미지 캡셔닝 모델 디코더에는 **Transformer 모델을 사용했다.**

![blue-score](https://user-images.githubusercontent.com/79498819/187978756-d9670b48-4f03-432f-8419-d0ec479c763e.png)


  본 프로젝트에서 사용한 **이미지 캡셔닝 모델의 구조는 다음과 같다.** 먼저 이미지가 CNN계열의 InceptionV3 에 입력되면 모델은 이미지에서 여러 특징을 분석한다. 가령 노균병에 감염된 애호박 잎사귀 이미지가 입력되면 모델은 잎의 가장자리에 노란 점박이가 생긴 모습, 잎의 색상 등을 분석하게 된다. 분석된 특징은 Transformer 모델에 입력된다. Transformer 모델 자체도 인코더-디코더 구조를 지니는데, 우선 이미지의 특징은 각 특징의 위치 정보와 함께 Transformer의 인코더에 입력되어 Self-Attention 과정을 거쳐 분석된 뒤 Transformer의 디코더에 입력된다. 또한 Transformer의 디코더에는 해당 이미지에 대한 정답 라벨인 실제 캡션 문장도 함께 입력되는데 이때 Transformer의 인코더에서 분석된 이미지 특징과 디코더에 입력된 실제 캡션 문장이 Self-Attention 과정으로 종합적으로 분석되고 최종적으로 Transformer 디코더에서 해당 이미지에 대해 모델이 예측한 캡션 문장이 생성된다.

### Object Detection

 **객체탐지(object-detection)은 한 이미지에서 객체와 그 경계 상자(bounding box)를 탐지하는 기술이다.** 객체 탐지 알고리즘은 일반적으로 이미지를 입력으로 받고, 경계 상자와 객체 클래스 리스트를 출력하며 이때 경계 상자에 대응하는 예측 클래스와 클래스의 신뢰도(confidence)를 출력한다. 2012년 이전까지는 non-neural network-based방식이 쓰이다가 2012년을 기점으로 neural network-based 기법이 활발히 연구되었다. 이 중 **우리가 사용한 모델은 2018년에 출시된 Yolo 모델이다.** 2022년 현재까지 V7까지 출시되었으며 V5부터는 PyTorch를 기반으로 구현되었기 때문에 파이썬 환경에서도 효과적으로 사용할 수 있게 되었다. 우리 조는 뛰어난 성능과 많은 참고문헌을 확보할 수 있는 **YoloV5를 모델을 활용**하였다. 

  모델을 본격적으로 구축하기 전에 데이터 수집을 진행하였다. 이미지 캡셔닝과 마찬가지로 AI-hub의 노지 작물 질병 진단 이미지 데이터셋과 시설 작물 질병 진단 데이터셋을 활용하였으며 고추, 애호박, 토마토, 콩, 파 등 **총 5개의 작물에서 9개의 질병**을 탐지하는 것을 목표로 하였다. 다만 흰가루병과 잎마름병은 2개의 작물에서 동시에 등장하는 질병이었기 때문에 **실제 예측 클래스는 7개로 지정**하였다.

  데이터 수집과 예측 클래스를 지정한 후 데이터 라벨링을 진행하였다. **LabelImg**라는 툴을 다운로드하고 작물 환부에 바운딩 박스(Bounding Box)를 만들었다.

활용할 수 있는 원천 데이터 사진은 6,000여 장이었는데, 모델을 학습시키기에는 충분하지 않은 양이었기 때문에 데이터 증강을 실시하였다. 파이썬 개발환경에서 **imgaug패키지**를 활용하여 증강 코드를 만들었고, 그 결과 train 25,458장, valid 5,936장, **총 31,394장의 이미지 데이터셋**을 구축하는데 성공했다. 아울러 개별 **이미지의 크기를 640 * 640으로 크기를 줄이는 작업도 실시**하였다. 

  이후 Yolov5 사전 모델을 다운로드하여 학습을 진행하였다. Yolov5에서 제공하는 사전 훈련 모델은 Yolov5n, Yolov5s, Yolov5m, Yolov5l, Yolov5x 총 5개이다. n에서 x로 갈수록 모델의 성능은 좋아지지만, 학습시키는데 더 많은 시간이 소요된다. 우리 조는 학습의 성능과 학습 시간을 적절히 고려하여 **Yolov5m모델을 채택**하여 학습을 시켰고 15시간에 걸친 끝에 모델 구축에 성공했다.

아래는 Yolov5 학습 결과의 Confusion Matrix 이다.
![confusion_matrix](https://user-images.githubusercontent.com/79498819/187980032-29b59f3a-f73b-485f-ae3e-2747037a042f.png)

# APP

 앱 프론트엔드 개발에는 구글에서 제공하는 Dart 언어기반의 무료 프레임워크인 **flutter**을 사용했으며 백엔드 개발에는 python 언어 기반 웹 프레임워크인 **flask**를 사용했다. 서버는 안정적이고 탄력성있는 성능으로 유명한 **AWS EC2**를 사용했으며 앱 UX/UI 디자인과 앱 서비스 플로우는 협업 디자인 툴인 **Figma**를 사용했다.

## Frontend

 애플리케이션 이름인 **Dr.쑥쑥**은 **식물의 질병을 진단하는 ‘식물 의사’의 뜻을 내포**하고 있다. 식물 의사라는 컨셉에 맞게 전체적으로 그린 **파스텔 톤**을 사용하여 디자인했고 누구나 사용하기 쉽게 심플한 UX/UI로 화면을 구성했다. 그리고 프론트엔드 부분에서 기존에 기획했던 **카메라, 날씨, 질병 진단, 그리고 방제 방법 제공 기능을 구현**했다. 카메라 기능은 flutter에서 제공하는 **image_picker** 패키지를 이용해 구현했고 날씨와 질병 진단 기능은 **서버와 클라이언트의 API 통신**을 통해 서비스에 필요한 데이터를 받아 앱 화면에 출력하는 방식으로 구현하였다. 마지막으로 질병에 따라 서로 다른 방제 방법을 소개하는 페이지로 이동할 수 있도록 앱을 구현했다.

## Backend & Server

먼저 개발 환경 구축이 중요하다고 생각했기에 이에 필요한 각 패키지와 라이브러리 등의 버전을 통일하고 공유하는 과정에 충분한 시간을 투자했다.

 이후 프론트엔드와 연동하는데 필요한 **API를 설계**하기 위해 직접 구조도를 그려보고 구체화하면서 핵심 백엔드 코드를 작성하였다.

 이미지 캡셔닝 모델과 오브젝트 디텍션 모델이 완성된 이후에는 **사전에 구축된 백엔드 서버에 두 모델을 이식**하는데 많은 공을 들였다. 두 모델을 한 화면에 동시에 보여줘야 했기 때문에 로직 구성 단계에서 고려해야 할 것들이 많았고, 결국 프론트엔드에서 전달된 사진을 저장하여 두 모델의 결과물인 캡션과 디텍션된 사진을 한 번에 프론트엔드로 전달하는 로직으로 모델 이식을 완료하였다.

 이 과정에서 **AWS EC2에서 무료로 사용할 수 있는 인스턴스 유형의 CPU(1GB)/메모리(RAM 1GB) 한계와 우리가 제작한 모델의 용량 문제로 인해 서버에 과부하가 일어나는 문제가 발생**하였고, 이를 해결하기 위하여 ‘AWS EC2’의 **하드디스크의 일부 용량을 swap memory로 할당**하였다. 이 과정을 통해 메모리에 여유를 주고, 서버의 부담이 줄어들면서 **서버가 안정화되는 효과**를 얻을 수 있었다.

# Benefits

 먼저 **농업에 대한 이미지를 개선**할 수 있다. 전문적인 관리 지식이 요구된다는 인식을 개선하여 **농업에 대한 접근성을 향상**할 수 있다. 

 두 번째로 여러 부가 서비스를 통해 **새내기 농부와 베테랑 농부의 가교역할**을 할 수 있다. **질병이 발생하는 환경과 질병 예방법을 짧은 문장으로 소개하여 앞으로 해당 질병을 예방하기 위한 환경과 예방 방법을 쉽게 파악**할 수 있도록 한다. 

 마지막으로 **농업 및 원예 시장의 발전에 긍정적 영향**을 줄 수 있다. 질병 진단의 대상을 더 많은 농작물로 확대할 수 있고 더 나아가 해당 질병에 걸릴 수 있는 반려 식물로도 확대할 수 있다. 이처럼 더 많은 종류의 식물에 대한 질병을 진단할 수 있는 방향으로 서비스를 발전시켜 **많은 사람이 식물 관리 서비스를 이용하도록 하고 궁극적으로 농업 및 원예 시장의 규모를 확대할 수 있을 것으로 기대**된다.

# References

Xu et al. "Show, attend and tell: Neural image caption generation with visual attention.", *International conference on machine learning*. PMLR, 2015.


Li et al. “Entangled Transformer for Image Captioning”, *Proceedings of the IEEE/CVF International Conference on Computer Vision (ICCV)*, 2019.


Taraneh et al. “Deep Learning Approaches on Image Captioning: A Review”, *arXiv preprint arXiv:2201.12944*, 2022.
