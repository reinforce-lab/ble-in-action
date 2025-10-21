# 第1章 はじめに

## Bluetooth LEとは

**Bluetooth Low Energy (BLE)** は、低消費電力のワイヤレス通信技術です。スマートフォン、ウェアラブルデバイス、IoTセンサーなど、様々な機器間のデータ交換に利用されています。

### BLEの特徴

- **低消費電力**: コイン電池で数ヶ月〜数年動作
- **短距離通信**: 最大100m (Class 1), 通常10-30m
- **低コスト**: シンプルなプロトコルスタック
- **汎用性**: iOS、Android、組み込みデバイスで広くサポート

## 本書の構成

| 章 | タイトル | 内容 |
|----|----------|------|
| 1 | はじめに | BLEの概要と本書の使い方 |
| 2 | BLE基礎 | プロトコル、GATT、UUID |
| 3 | 組み込み開発 | ペリフェラル実装 (C言語) |
| 4 | iOS開発 | セントラル実装 (Swift) |
| 5 | Android開発 | セントラル実装 (Kotlin) |

## 技術要件

本書のサンプルコードを動かすには、以下の環境が必要です:

### 組み込み開発環境

```c
// nRF52840を使用した温度センサーの例
#include <zephyr/bluetooth/bluetooth.h>
#include <zephyr/bluetooth/uuid.h>

#define BT_UUID_TEMP_SERVICE_VAL \
    BT_UUID_128_ENCODE(0x12345678, 0x1234, 0x5678, 0x1234, 0x56789abcdef0)

static struct bt_uuid_128 temp_service_uuid = BT_UUID_INIT_128(
    BT_UUID_TEMP_SERVICE_VAL);

// 温度データを読み取るGATT特性
static ssize_t read_temperature(struct bt_conn *conn,
                                const struct bt_gatt_attr *attr,
                                void *buf, uint16_t len, uint16_t offset)
{
    int16_t temp = get_temperature_celsius();
    return bt_gatt_attr_read(conn, attr, buf, len, offset, 
                             &temp, sizeof(temp));
}
```

### iOS開発環境

```swift
// Core Bluetoothを使用したセントラル実装
import CoreBluetooth

class BLEManager: NSObject, CBCentralManagerDelegate {
    private var centralManager: CBCentralManager!
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            // UUIDを指定してスキャン開始
            let serviceUUID = CBUUID(string: "12345678-1234-5678-1234-56789ABCDEF0")
            centralManager.scanForPeripherals(
                withServices: [serviceUUID],
                options: nil
            )
        }
    }
}
```

### Android開発環境

```kotlin
// Bluetooth LEを使用したセントラル実装
import android.bluetooth.*
import android.content.Context

class BLEManager(private val context: Context) {
    private val bluetoothManager = context.getSystemService(
        Context.BLUETOOTH_SERVICE
    ) as BluetoothManager
    
    private val bluetoothAdapter = bluetoothManager.adapter
    
    fun startScan() {
        val scanner = bluetoothAdapter.bluetoothLeScanner
        val serviceUuid = UUID.fromString(
            "12345678-1234-5678-1234-56789ABCDEF0"
        )
        
        val scanFilter = ScanFilter.Builder()
            .setServiceUuid(ParcelUuid(serviceUuid))
            .build()
        
        scanner.startScan(
            listOf(scanFilter),
            ScanSettings.Builder().build(),
            scanCallback
        )
    }
}
```

## アーキテクチャ概要

![BLEシステム全体構成](../images/diagrams/sample-architecture.png)

上図は、BLEシステムの典型的な構成を示しています:

1. **ペリフェラル** (組み込みデバイス): データを提供する側
2. **セントラル** (スマートフォン): データを受信する側
3. **GATT サーバー**: ペリフェラル側のデータ構造
4. **GATT クライアント**: セントラル側のアクセス方法

## 専門用語の説明

本書では、以下のような専門用語を使用します:

- **BLE** (Bluetooth Low Energy): 低消費電力Bluetooth規格
- **GATT** (Generic Attribute Profile): BLEのデータ交換プロトコル
- **UUID** (Universally Unique Identifier): サービスや特性を識別する128ビット値
- **ATT** (Attribute Protocol): GATTの基礎となる属性プロトコル
- **セントラル/ペリフェラル**: BLEにおけるクライアント/サーバーの役割

## 次の章へ

次章では、BLEプロトコルスタックの詳細と、GATT の基本概念について学びます。実際のデータ構造や通信フローを理解することで、効率的なBLEアプリケーションを設計できるようになります。
