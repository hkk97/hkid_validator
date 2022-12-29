# HKID Validator - Flutter Web Demo
[![DockerCICD](https://github.com/hkk97/hkid_validator/actions/workflows/docker-cicd.yml/badge.svg)](https://github.com/hkk97/hkid_validator/actions/workflows/docker-cicd.yml)
[![ForkCICD](https://github.com/hkk97/hkid_validator/actions/workflows/fork-cicd.yml/badge.svg)](https://github.com/hkk97/hkid_validator/actions/workflows/fork-cicd.yml)
[![GitHubPageCICD](https://github.com/hkk97/hkid_validator/actions/workflows/github-page-cicd.yml/badge.svg)](https://github.com/hkk97/hkid_validator/actions/workflows/github-page-cicd.yml)
[![GithubPacakgesCICD](https://github.com/hkk97/hkid_validator/actions/workflows/github-packages-cicd.yml/badge.svg)](https://github.com/hkk97/hkid_validator/actions/workflows/github-packages-cicd.yml)
[![pages-build-deployment](https://github.com/hkk97/hkid_validator/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/hkk97/hkid_validator/actions/workflows/pages/pages-build-deployment)
[![CodeFactor](https://www.codefactor.io/repository/github/hkk97/hkid_validator/badge)](https://www.codefactor.io/repository/github/hkk97/hkid_validator)

The UI of HKID Validator Web App, was inspired by [icelam](https://github.com/icelam/hkid-generator).
A Flutter Web Demo for HKID Validator, this web demo is used to demonstrate the powerful of Flutter in Web Development and the usage of the packages called [hkid_validator](../lib/hkid_validator.dart). 

<p align="center">
     <a href="https://github.com/flutter/flutter/tree/3.3" alt="Flutter">
        <img src="https://img.shields.io/badge/Flutter-v3.3.0 (stable)-4BC51D.svg?style=flat" /></a>
     <a alt="**Dart**">
        <img src="https://img.shields.io/badge/Dart-v2.18.0 (stable)-4BC51D.svg?style=flat" /></a>
     <a alt="DevTools">
        <img src="https://img.shields.io/badge/DevTools-v2.15.0 (stable)-4BC51D.svg?style=flat" /></a>
     <a alt="VS Code">
        <img src="https://img.shields.io/badge/VS Code-v1.67.2-4BC51D.svg?style=flat" /></a>
</p>

### Used third party libraries as below:
<p align="center">
     <a href="https://pub.dev/packages/intl" alt="intl">
        <img src="https://img.shields.io/badge/intl-^0.17.0 -4BC51D.svg?style=flat" /></a>
     <a href="https://pub.dev/packages/get" alt="get">
        <img src="https://img.shields.io/badge/get-^4.6.5 -4BC51D.svg?style=flat" /></a>
     <a href="https://pub.dev/packages/get_storage" alt="intl">
        <img src="https://img.shields.io/badge/get_storage-^2.0.3 -4BC51D.svg?style=flat" /></a>     
     <a href="https://pub.dev/packages/sembast_web" alt="intl">
        <img src="https://img.shields.io/badge/sembast_web-^2.0.1+1-4BC51D.svg?style=flat" /></a>     
     <a href="https://pub.dev/packages/sembast" alt="intl">
        <img src="https://img.shields.io/badge/sembast-^>=3.1.1 <5.0.0 -4BC51D.svg?style=flat" /></a>     
     <a href="https://pub.dev/packages/idb_shim" alt="idb_shim">
        <img src="https://img.shields.io/badge/idb_shim-^>=2.0.1 <4.0.0 -4BC51D.svg?style=flat" /></a>
</p>

## Design Pattern
- Creational - Singleton and Factory

## Statue Management Approach
- StatefulWidget
- StatefulWidget with ValueNotifier
- StatelessWidget

## Storage Methodology
Local Storage and IndexedDB are used on this project. Local storage used to store the locale of the web and status of web; IndexedDB used to store the Generated HKID and Validated HKID.
Storage:
- Local Storage
  - sysConfig
  - secureStorage
  - container
- IndexedDB
  - GeneratedID
  - ValidatedID

## Localhost Running
$ flutter run --web-renderer html --no-sound-null-safety --dart-define=ENV=DEV -dart-define=FLUTTER_WEB_USE_SKIA=true -d chrome --release


# HKID Validator Demo
| | |
|:-------------------------:|:-------------------------:|
|<img width="1604" src="../example/demo/generated_section.png"> | 
|<img width="1604" src="../example/demo/generated_drawer.png"> | 
|<img width="1604" src="../example/demo/validated_section.png"> | 
|<img width="1604" src="../example/demo/validated_drawer.png"> | 
