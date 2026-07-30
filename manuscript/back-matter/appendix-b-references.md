# 付録B: 参考文献

<!-- topic: 公式仕様書, 参考書, Webリソース, SDK ドキュメント -->


## 公式仕様書・標準文書

### Bluetooth SIG

| 仕様書 | URL |
|---|---|
| Bluetooth Core Specification 6.3 | https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core_v6.3/out/en/index-en.html |
| GATT Specification Supplement (GSS) | https://www.bluetooth.com/specifications/specs/gatt-specification-supplement/ |
| Assigned Numbers | https://www.bluetooth.com/specifications/assigned-numbers/ |
| Heart Rate Profile 1.0 | https://www.bluetooth.com/specifications/specs/heart-rate-profile-1-0/ |
| Understanding Bluetooth Range（参照日: 2026-07-29） | https://www.bluetooth.com/learn-about-bluetooth/key-attributes/range/ |
| 3 Common Myths About Bluetooth Technology（参照日: 2026-07-29） | https://www.bluetooth.com/blog/3-common-mythsabout-bluetooth/ |

### Connectivity Standards Alliance

| 仕様書 | URL |
|---|---|
| Matter Core Specification 1.4（参照日: 2026-07-30） | https://csa-iot.org/wp-content/uploads/2024/11/24-27349-006_Matter-1.4-Core-Specification.pdf |

### 日本の法令

| 文書 | 発行主体 | URL |
|---|---|---|
| 無線設備規則（昭和二十五年電波監理委員会規則第十八号） | e-Gov法令検索 | https://laws.e-gov.go.jp/law/325M50080000018 |


## nRF Connect SDK / Zephyr RTOS

| リソース | URL |
|---|---|
| nRF Connect SDK ドキュメント | https://developer.nordicsemi.com/nRF_Connect_SDK/doc/latest/ |
| Zephyr Project ドキュメント | https://docs.zephyrproject.org/latest/ |
| Zephyr BLE サンプル集 | https://docs.zephyrproject.org/latest/samples/bluetooth/ |
| Nordic Semiconductor DevZone（Q&Aフォーラム） | https://devzone.nordicsemi.com/ |
| nRF Connect SDK GitHub | https://github.com/nrfconnect/sdk-nrf |


## Apple / iOS

| リソース | URL |
|---|---|
| Core Bluetoothドキュメント（参照日: 2026-07-29） | https://developer.apple.com/documentation/corebluetooth |
| Core Bluetooth Background Processing for iOS Apps（参照日: 2026-07-29） | https://developer.apple.com/library/archive/documentation/NetworkingInternetWeb/Conceptual/CoreBluetooth_concepts/CoreBluetoothBackgroundProcessingForIOSApps/PerformingTasksWhileYourAppIsInTheBackground.html |
| scanForPeripherals(withServices:options:)（参照日: 2026-07-29） | https://developer.apple.com/documentation/corebluetooth/cbcentralmanager/scanforperipherals(withservices:options:) |
| CBCentralManagerScanOptionAllowDuplicatesKey（参照日: 2026-07-29） | https://developer.apple.com/documentation/corebluetooth/cbcentralmanagerscanoptionallowduplicateskey |
| centralManager(_:didDiscover:advertisementData:rssi:)（参照日: 2026-07-29） | https://developer.apple.com/documentation/corebluetooth/cbcentralmanagerdelegate/centralmanager(_:diddiscover:advertisementdata:rssi:) |
| Getting Started with iBeacon, Version 1.0（参照日: 2026-07-29） | https://developer.apple.com/ibeacon/Getting-Started-with-iBeacon.pdf |
| WWDC 2020: What's new in Core Bluetooth | https://developer.apple.com/videos/play/wwdc2020/10065/ |
| WWDC 2017: What's New in Core Bluetooth | https://developer.apple.com/videos/play/wwdc2017/712/ |
| Swift Charts ドキュメント | https://developer.apple.com/documentation/charts |


## Android / Google

| リソース | URL |
|---|---|
| Android BLE ガイド | https://developer.android.com/guide/topics/connectivity/bluetooth/ble-overview |
| Android Bluetooth 権限ガイド | https://developer.android.com/guide/topics/connectivity/bluetooth/permissions |
| Android Kotlin サンプル（BluetoothLeGatt） | https://github.com/android/connectivity-samples |


## Linux / Python

| リソース | URL |
|---|---|
| BlueZ 公式サイト | http://www.bluez.org/ |
| BlueZ D-Bus API ドキュメント | https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc |
| bleak Python ライブラリ | https://bleak.readthedocs.io/ |
| bleak GitHub | https://github.com/hbldh/bleak |


## Web Bluetooth

| リソース | URL |
|---|---|
| Web Bluetooth API 仕様 | https://webbluetoothcg.github.io/web-bluetooth/ |
| Chrome Developers: Web Bluetooth | https://developer.chrome.com/articles/bluetooth/ |
| Web Bluetooth サンプル集 | https://googlechrome.github.io/samples/web-bluetooth/ |
| ブラウザ対応状況 | https://caniuse.com/web-bluetooth |


## ビーコン関連

| リソース | URL |
|---|---|
| iBeacon開発者ページ（Apple、参照日: 2026-07-29） | https://developer.apple.com/ibeacon/ |
| Eddystone Protocol Specification（Google、アーカイブ済み、参照日: 2026-07-29） | https://github.com/google/eddystone/blob/master/protocol-specification.md |
| Find Hub Network Accessory Specification Version 1.3（Google、参照日: 2026-07-29） | https://developers.google.com/nearby/fast-pair/specifications/extensions/fmdn |
| Partner Integration Guide for Google's Find Hub Network（Google、参照日: 2026-07-29） | https://developers.google.com/nearby/fast-pair/landing-page-find-hub |


## OTA DFU

| リソース | URL |
|---|---|
| MCUBoot ドキュメント | https://docs.mcuboot.com/ |
| nRF Connect Device Manager (iOS) | https://github.com/NordicSemiconductor/IOS-nRF-Connect-Device-Manager |
| nRF Connect Device Manager (Android) | https://github.com/NordicSemiconductor/Android-nRF-Connect-Device-Manager |
| imgtool（MCUBoot署名ツール） | https://docs.mcuboot.com/imgtool.html |


## デバッグ・解析ツール

| ツール | URL |
|---|---|
| nRF Sniffer for Bluetooth LE | https://infocenter.nordicsemi.com/topic/ug_sniffer_ble/UG/sniffer_ble/intro.html |
| Wireshark | https://www.wireshark.org/ |
| Wireshark BLE Dissector ドキュメント | https://wiki.wireshark.org/Bluetooth |
| nRF Power Profiler Kit II (PPK2) | https://www.nordicsemi.com/Products/Development-hardware/Power-Profiler-Kit-2 |


## 参考書籍

| 書名 | 著者 | 出版社 |
|---|---|---|
| *Getting Started with Bluetooth Low Energy* | Kevin Townsend 他 | O'Reilly Media |
| *Bluetooth Low Energy: The Developer's Handbook* | Robin Heydon | Prentice Hall |
| *Bluetooth Application Developer's Guide* | Slee / Sherrill / Bhatt | Syngress |


## コミュニティ・その他

| リソース | URL |
|---|---|
| Bluetooth SIG Developer Resources | https://www.bluetooth.com/develop-with-bluetooth/ |
| Stack Overflow [bluetooth-lowenergy] タグ | https://stackoverflow.com/questions/tagged/bluetooth-lowenergy |
| Reddit r/embedded | https://www.reddit.com/r/embedded/ |


*本書中のリンクは2025年時点のものです。URLは変更になる場合があります。*
