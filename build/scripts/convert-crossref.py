#!/usr/bin/env python3
"""Convert hardcoded section/chapter references to pandoc-crossref syntax.

1. Add {#sec:label} to the first non-comment ## heading in each section file
2. Add {#sec:chN} to the first non-comment # heading in each X.0-intro.md
3. Replace "X.Y節" → [@sec:label] in prose text
4. Replace "第X章" → [@sec:chN] in prose text
5. Skip: HTML comments, code blocks, table rows, ASCII art, heading lines
"""

import re
import os

BASE = "/Users/u_akihiro/Desktop/BLEInAction/manuscript"

# ──────────────────────────────────────────────────────────────
# Label definitions: file path (relative to chapters/) → label
# ──────────────────────────────────────────────────────────────
FILE_SEC_LABELS = {
    # Chapter 1
    "01-what-is-ble/1.1-starting-with-microbit.md": "microbit",
    "01-what-is-ble/1.2-ble-introduction.md": "ble-intro",
    "01-what-is-ble/1.3-ble-ecosystem.md": "ble-ecosystem",
    "01-what-is-ble/1.3-development-styles.md": "dev-roles",
    "01-what-is-ble/1.4-summary.md": "ch1-summary",
    # Chapter 2
    "02-ble-basic/2.1-ble-overview.md": "ble-overview",
    "02-ble-basic/2.2-advertising-scanning.md": "adv-scan",
    "02-ble-basic/2.3-connection.md": "connection",
    "02-ble-basic/2.4-pairing-bonding.md": "pairing",
    "02-ble-basic/2.5-packet-path.md": "packet-path",
    "02-ble-basic/2.6-data-exchange.md": "data-exchange",
    "02-ble-basic/2.7-summary.md": "ch2-summary",
    # Chapter 3
    "03-ble-layer/3.1-stack-overview.md": "stack-overview",
    "03-ble-layer/3.2-physical-layer.md": "physical-layer",
    "03-ble-layer/3.3-link-layer-state-machine.md": "link-layer",
    "03-ble-layer/3.4-advertising-packet.md": "adv-packet",
    "03-ble-layer/3.5-connection-establishment.md": "conn-establish",
    "03-ble-layer/3.6-gap.md": "gap",
    "03-ble-layer/3.7-summary.md": "ch3-summary",
    # Chapter 4
    "04-att-gatt/4.1-att-gatt-overview.md": "att-gatt-overview",
    "04-att-gatt/4.2-attribute-structure.md": "att-structure",
    "04-att-gatt/4.3-att-commands.md": "att-commands",
    "04-att-gatt/4.4-gatt-hierarchy.md": "gatt-hierarchy",
    "04-att-gatt/4.5-descriptors.md": "descriptors",
    "04-att-gatt/4.6-profiles.md": "profiles",
    "04-att-gatt/4.7-summary.md": "ch4-summary",
    # Chapter 5
    "05-nrf52840-setup/5.1-overview.md": "nrf-overview",
    "05-nrf52840-setup/5.2-sdk-setup.md": "sdk-setup",
    "05-nrf52840-setup/5.3-board-setup.md": "board-setup",
    "05-nrf52840-setup/5.4-hello-ble.md": "hello-ble",
    "05-nrf52840-setup/5.5-project-structure.md": "project-structure",
    "05-nrf52840-setup/5.6-summary.md": "ch5-summary",
    # Chapter 6
    "06-peripheral-impl/6.1-connectable-adv.md": "connectable-adv",
    "06-peripheral-impl/6.2-custom-service.md": "custom-service",
    "06-peripheral-impl/6.3-read-characteristic.md": "read-char",
    "06-peripheral-impl/6.4-write-characteristic.md": "write-char",
    "06-peripheral-impl/6.5-notify.md": "notify-impl",
    "06-peripheral-impl/6.6-connection.md": "conn-mgmt",
    "06-peripheral-impl/6.7-summary.md": "ch6-summary",
    # Chapter 7
    "07-low-power-design/7.1-power-basics.md": "power-basics",
    "07-low-power-design/7.2-sleep-mode.md": "sleep-mode",
    "07-low-power-design/7.3-adv-interval.md": "adv-interval",
    "07-low-power-design/7.4-conn-interval.md": "conn-interval",
    "07-low-power-design/7.5-ppk2-measurement.md": "ppk2",
    "07-low-power-design/7.6-battery-design.md": "battery",
    "07-low-power-design/7.7-summary.md": "ch7-summary",
    # Chapter 8
    "08-external-chips/8.1-overview.md": "ext-overview",
    "08-external-chips/8.2-sensor-integration.md": "sensor-integration",
    "08-external-chips/8.3-hci-interface.md": "hci-interface",
    "08-external-chips/8.4-lte-ble-integration.md": "lte-ble",
    "08-external-chips/8.5-power-pitfalls.md": "power-pitfalls",
    "08-external-chips/8.6-summary.md": "ch8-summary",
    # Chapter 9
    "09-ios-core-bluetooth/9.1-framework-overview.md": "cb-overview",
    "09-ios-core-bluetooth/9.2-centralmanager.md": "centralmanager",
    "09-ios-core-bluetooth/9.3-scanning.md": "cb-scanning",
    "09-ios-core-bluetooth/9.4-service-discovery.md": "service-discovery",
    "09-ios-core-bluetooth/9.5-read-write.md": "cb-read-write",
    "09-ios-core-bluetooth/9.6-notify.md": "cb-notify",
    "09-ios-core-bluetooth/9.7-background.md": "background",
    "09-ios-core-bluetooth/9.8-summary.md": "ch9-summary",
    # Chapter 10
    "10-web-bluetooth/10.1-overview.md": "web-overview",
    "10-web-bluetooth/10.2-request-device.md": "request-device",
    "10-web-bluetooth/10.3-connect-gatt.md": "connect-gatt",
    "10-web-bluetooth/10.4-read-write.md": "web-read-write",
    "10-web-bluetooth/10.5-notify.md": "web-notify",
    "10-web-bluetooth/10.6-limitations-summary.md": "ch10-summary",
    # Chapter 11
    "11-android-linux-ble/11.1-android-overview.md": "android-overview",
    "11-android-linux-ble/11.2-android-scan-connect.md": "android-scan",
    "11-android-linux-ble/11.3-android-gatt-issues.md": "android-gatt",
    "11-android-linux-ble/11.4-linux-bluez.md": "linux-bluez",
    "11-android-linux-ble/11.5-python-bleak.md": "python-bleak",
    "11-android-linux-ble/11.6-platform-comparison.md": "platform-compare",
    # Chapter 12
    "12-beacon-impl/12.1-beacon-overview.md": "beacon-overview",
    "12-beacon-impl/12.2-nrf52840-beacon.md": "nrf-beacon",
    "12-beacon-impl/12.3-ios-beacon-reception.md": "ios-beacon",
    "12-beacon-impl/12.4-android-beacon.md": "android-beacon",
    "12-beacon-impl/12.5-eddystone-url.md": "eddystone",
    "12-beacon-impl/12.6-summary.md": "ch12-summary",
    # Chapter 13
    "13-thermometer-impl/13.1-system-architecture.md": "thermo-arch",
    "13-thermometer-impl/13.2-firmware-sensor.md": "thermo-fw",
    "13-thermometer-impl/13.3-firmware-gatt.md": "thermo-gatt",
    "13-thermometer-impl/13.4-ios-ble-receive.md": "thermo-ios",
    "13-thermometer-impl/13.5-ios-chart.md": "thermo-chart",
    "13-thermometer-impl/13.6-summary.md": "ch13-summary",
    # Chapter 14
    "14-ota-dfu/14.1-dfu-overview.md": "dfu-overview",
    "14-ota-dfu/14.2-mcuboot-config.md": "mcuboot",
    "14-ota-dfu/14.3-dfu-package.md": "dfu-package",
    "14-ota-dfu/14.4-smp-protocol.md": "smp",
    "14-ota-dfu/14.5-ios-dfu.md": "ios-dfu",
    "14-ota-dfu/14.6-troubleshooting.md": "dfu-trouble",
    "14-ota-dfu/14.7-summary.md": "ch14-summary",
    # Chapter 15
    "15-debugging/15.1-debug-tools-overview.md": "debug-tools",
    "15-debugging/15.2-nrf-sniffer-setup.md": "sniffer-setup",
    "15-debugging/15.3-wireshark-analysis.md": "wireshark",
    "15-debugging/15.4-ios-debugging.md": "ios-debug",
    "15-debugging/15.5-android-hci-snoop.md": "hci-snoop",
    "15-debugging/15.6-debug-examples.md": "debug-examples",
    # Chapter 16
    "16-troubleshooting/16.1-connection-issues.md": "conn-issues",
    "16-troubleshooting/16.2-data-issues.md": "data-issues",
    "16-troubleshooting/16.3-power-issues.md": "power-issues",
    "16-troubleshooting/16.4-platform-specific.md": "platform-specific",
    "16-troubleshooting/16.5-ota-security-issues.md": "ota-security",
    "16-troubleshooting/16.6-faq-summary.md": "ch16-summary",
}

# Build "X.Y" → "sec:label" map
SEC_REF = {}
for fpath, label in FILE_SEC_LABELS.items():
    # Extract X.Y from filename like "01-what-is-ble/1.3-ble-ecosystem.md"
    fname = os.path.basename(fpath)
    m = re.match(r'(\d+\.\d+)-', fname)
    if m:
        SEC_REF[m.group(1)] = f"sec:{label}"

# Chapter intro files → chapter labels
CHAP_INTRO_FILES = {}
for i in range(1, 17):
    dirs = [d for d in os.listdir(os.path.join(BASE, "chapters"))
            if d.startswith(f"{i:02d}-")]
    if dirs:
        intro = os.path.join("chapters", dirs[0], f"{i}.0-intro.md")
        if os.path.exists(os.path.join(BASE, intro)):
            CHAP_INTRO_FILES[intro] = f"ch{i}"

# Chapter number → label
CHAP_REF = {str(i): f"sec:ch{i}" for i in range(1, 17)}


def parse_context(lines):
    """Return list of context types for each line: 'prose', 'comment', 'code', 'table', 'ascii', 'heading'."""
    contexts = []
    in_comment = False
    in_code = False

    for line in lines:
        stripped = line.strip()

        # Code block toggle (must check before other rules)
        if stripped.startswith('```'):
            if in_code:
                contexts.append('code')
                in_code = False
                continue
            else:
                in_code = True
                contexts.append('code')
                continue

        if in_code:
            contexts.append('code')
            continue

        # Multi-line comment tracking
        if in_comment:
            contexts.append('comment')
            if '-->' in line:
                in_comment = False
            continue

        # Single-line comment
        if '<!--' in stripped and '-->' in stripped:
            contexts.append('comment')
            continue

        # Start of multi-line comment
        if '<!--' in stripped:
            in_comment = True
            contexts.append('comment')
            continue

        # Heading line
        if re.match(r'^#{1,6}\s', stripped):
            contexts.append('heading')
            continue

        # Table row
        if stripped.startswith('|'):
            contexts.append('table')
            continue

        # ASCII art (box drawing chars)
        if any(c in line for c in '├│└┌┐┘╠═╬║╗╝╚╔┃┏┓┗┛━┣┫┳┻╋'):
            contexts.append('ascii')
            continue

        contexts.append('prose')

    return contexts


def add_heading_ids():
    """Add {#sec:label} to the first non-comment section headings."""
    changes = 0

    # Section files: add {#sec:label} to first non-comment ## heading
    for fpath, label in FILE_SEC_LABELS.items():
        fullpath = os.path.join(BASE, "chapters", fpath)
        if not os.path.exists(fullpath):
            print(f"  SKIP (not found): {fpath}")
            continue

        with open(fullpath, 'r', encoding='utf-8') as f:
            lines = f.readlines()

        contexts = parse_context(lines)
        modified = False

        for i, (line, ctx) in enumerate(zip(lines, contexts)):
            stripped = line.strip()
            # Find first ## heading that is NOT in a comment
            if ctx != 'heading':
                continue
            if not re.match(r'^##\s+', stripped):
                continue
            # Already has {#sec:...}?
            if '{#sec:' in line:
                break
            # Add the ID
            line_stripped = line.rstrip('\n')
            lines[i] = f"{line_stripped} {{#sec:{label}}}\n"
            modified = True
            break

        if modified:
            with open(fullpath, 'w', encoding='utf-8') as f:
                f.writelines(lines)
            changes += 1
            print(f"  ID added: {fpath} → sec:{label}")

    # Chapter intro files: add {#sec:chN} to first non-comment # heading
    for fpath, label in CHAP_INTRO_FILES.items():
        fullpath = os.path.join(BASE, fpath)
        if not os.path.exists(fullpath):
            print(f"  SKIP (not found): {fpath}")
            continue

        with open(fullpath, 'r', encoding='utf-8') as f:
            lines = f.readlines()

        contexts = parse_context(lines)
        modified = False

        for i, (line, ctx) in enumerate(zip(lines, contexts)):
            stripped = line.strip()
            if ctx != 'heading':
                continue
            if not re.match(r'^#\s+', stripped) or re.match(r'^##', stripped):
                continue  # Must be single # heading
            if '{#sec:' in line:
                break
            line_stripped = line.rstrip('\n')
            lines[i] = f"{line_stripped} {{#sec:{label}}}\n"
            modified = True
            break

        if modified:
            with open(fullpath, 'w', encoding='utf-8') as f:
                f.writelines(lines)
            changes += 1
            print(f"  ID added: {fpath} → sec:{label}")

    return changes


def replace_section_ref(text):
    """Replace X.Y節 with [@sec:label] in a single prose line."""
    # Pattern: 第X.Y節 → [@sec:label]  (remove 第)
    def repl_dai_sec(m):
        key = m.group(1)
        if key in SEC_REF:
            return f"[@{SEC_REF[key]}]"
        return m.group(0)  # Leave unchanged if not in map

    text = re.sub(r'第(\d+\.\d+)節', repl_dai_sec, text)

    # Pattern: standalone X.Y節 (not preceded by 第 or @)
    def repl_sec(m):
        key = m.group(1)
        if key in SEC_REF:
            return f"[@{SEC_REF[key]}]"
        return m.group(0)

    text = re.sub(r'(?<!第)(?<!@)(\d+\.\d+)節', repl_sec, text)

    return text


def replace_chapter_ref(text):
    """Replace 第X章 with [@sec:chN] in a single prose line."""
    def repl_chap(m):
        num = m.group(1)
        if num in CHAP_REF:
            return f"[@{CHAP_REF[num]}]"
        return m.group(0)

    text = re.sub(r'第(\d+)章', repl_chap, text)
    return text


def replace_references():
    """Replace all direct numeric references in prose text across all built files."""
    # Get all built files from chapters.txt
    chapters_txt = os.path.join(BASE, "chapters.txt")
    built_files = []
    with open(chapters_txt, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            built_files.append(os.path.join(BASE, line))

    total_changes = 0

    for fpath in built_files:
        if not os.path.exists(fpath):
            continue

        with open(fpath, 'r', encoding='utf-8') as f:
            lines = f.readlines()

        contexts = parse_context(lines)
        modified = False
        file_changes = 0

        for i, (line, ctx) in enumerate(zip(lines, contexts)):
            if ctx != 'prose':
                continue

            new_line = line
            new_line = replace_section_ref(new_line)
            new_line = replace_chapter_ref(new_line)

            if new_line != line:
                lines[i] = new_line
                modified = True
                file_changes += 1

        if modified:
            with open(fpath, 'w', encoding='utf-8') as f:
                f.writelines(lines)
            rel = os.path.relpath(fpath, BASE)
            print(f"  {rel}: {file_changes} line(s) changed")
            total_changes += file_changes

    return total_changes


def main():
    print("=" * 60)
    print("pandoc-crossref conversion")
    print("=" * 60)

    print("\n[1/2] Adding heading IDs...")
    id_count = add_heading_ids()
    print(f"  → {id_count} headings modified")

    print("\n[2/2] Replacing direct references...")
    ref_count = replace_references()
    print(f"  → {ref_count} lines modified")

    print("\n✅ Done.")


if __name__ == "__main__":
    main()
