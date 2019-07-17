# valve-eks

EKS 클러스터를 구성하기 위한 terraform 스크립트 템플릿을 제공합니다.
AWS 에서 EKS를 사용해서 클러스터를 구성하기 위해서는 AWS의 다양한 리소스를 정의하고 이를 통해 운영 환경을 구성할 수 있어야 합니다.

초기에 구성된 EKS 기반 코러산트 클러스터는 재사용이 가능한 terraform 모듈로 정의되었습니다.
하자만, 모듈이 업그레이드 될 때 이 모듈을 통해 생성된 실 환경은 모듈 변경과 동시에 업데이트 되지 못하고 코드와 실제 환경이 다른 소위 'OutOfSync' 상태로 남게되는 문제가 발생하였습니다. 이러한 불일치가 누적되면 코드 변경도 자유롭지 못하고 실 환경 업그레이드도 재대로 진행되지 못하는 문제가 있습니다.

이 프로젝트는 EKS 생성을 위한 템플릿 코드를 제공하는 것을 목적으로 합니다.

이 프로젝트에서 제공되는 템플릿 코드를 활용하여 인프라를 구성하는 실제코드를 정의하는 GitOps 프로젝트를 생성할 수 있습니다.