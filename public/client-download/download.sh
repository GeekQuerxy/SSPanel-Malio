#!/bin/bash

get_latest_release() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
        grep '"tag_name":' | # Get tag line
        sed -E 's/.*"([^"]+)".*/\1/' # Pluck JSON value
}

git clone https://github.com/xcxnig/ssr-download.git deploy

# Clash for Windows

echo "==========================================================================="
echo "* Clash for Windows"
echo "https://github.com/Fndroid/clash_for_windows_pkg"

clash_for_windows_pkg_version=$(get_latest_release "Fndroid/clash_for_windows_pkg")

echo "Latest Verison: $clash_for_windows_pkg_version"


mkdir -p Clash-Windows
wget -o /dev/null -O Clash-Windows/Clash.for.Windows.Setup.$clash_for_windows_pkg_version.exe "https://github.com/Fndroid/clash_for_windows_pkg/releases/download/$clash_for_windows_pkg_version/Clash.for.Windows.Setup.$clash_for_windows_pkg_version.exe"
7za a Clash-Windows.7z ./Clash-Windows/*
[ -d "Clash-Windows.7z" ] && mv -f Clash-Windows.7z ./deploy/Clash-Windows.7z
rm -rf Clash-Windows


sleep 35

# clashX(macOS)

echo "==========================================================================="
echo "* ClashX (for macOS)"
echo "https://github.com/yichengchen/clashX"

clashx_version=$(get_latest_release "yichengchen/clashX")

echo "Latest Verison: $clashx_version"


wget -o /dev/null -O ClashX.dmg "https://github.com/yichengchen/clashX/releases/download/$clashx_version/ClashX.dmg"
[ -d "ClashX.dmg" ] && mv -f ClashX.dmg ./deploy/ClashX.dmg


sleep 35

# Shadowsocks Android

echo "==========================================================================="
echo "* Shadowsocks Android"
echo "https://github.com/shadowsocks/shadowsocks-android"

ss_android_version=$(get_latest_release "shadowsocks/shadowsocks-android" | sed 's|v||g')

echo "Latest Verison: $ss_android_version"


wget -o /dev/null -O ss-android.apk "https://github.com/shadowsocks/shadowsocks-android/releases/download/v$ss_android_version/shadowsocks--universal-$ss_android_version.apk"
[ -d "ss-android.apk" ] && mv -f ss-android.apk ./deploy/ss-android.apk


sleep 35

# Shadowsocks Windows

echo "==========================================================================="
echo "* Shadowsocks Windows"
echo "https://github.com/shadowsocks/shadowsocks-windows"

ss_windows_version=$(get_latest_release "shadowsocks/shadowsocks-windows")

echo "Latest Verison: $ss_windows_version"


wget -o /dev/null -O ss-win.zip "https://github.com/shadowsocks/shadowsocks-windows/releases/download/$ss_windows_version/Shadowsocks-$ss_windows_version.zip"
[ -d "ss-win.zip" ] && mv -f ss-win.zip ./deploy/ss-win.zip


sleep 35

# ShadowsocksX-NG

echo "==========================================================================="
echo "* ShadowsocksX-NG (macOS)"
echo "https://github.com/shadowsocks/ShadowsocksX-NG"

ss_mac_version=$(get_latest_release "shadowsocks/ShadowsocksX-NG" | sed 's|v||g')

echo "Latest Verison: $ss_mac_version"


wget -o /dev/null -O ss-mac.zip "https://github.com/shadowsocks/ShadowsocksX-NG/releases/download/v$ss_mac_version/ShadowsocksX-NG.app.$ss_mac_version.zip"
[ -d "ss-mac.zip" ] && mv -f ss-mac.zip ./deploy/ss-mac.zip


sleep 35

# ShadowsocksD Android

echo "==========================================================================="
echo "* ShadowsocksD Android"
echo "https://github.com/TheCGDF/SSD-Android"

ssd_android_version=$(get_latest_release "TheCGDF/SSD-Android")

echo "Latest Verison: $ssd_android_version"


wget -o /dev/null -O ssd-android.apk "https://github.com/TheCGDF/SSD-Android/releases/download/$ssd_android_version/shadowsocksd_$ssd_android_version.apk"
[ -d "ssd-android.apk" ] && mv -f ssd-android.apk ./deploy/ssd-android.apk


sleep 35

# ShadowsocksD Windows

echo "==========================================================================="
echo "* ShadowsocksD Windows"
echo "https://github.com/TheCGDF/SSD-Windows"

ssd_windows_version=$(get_latest_release "TheCGDF/SSD-Windows")

echo "Latest Verison: $ssd_windows_version"


mkdir -p SSD-Windows
wget -o /dev/null -O ssd-win.zip "https://github.com/TheCGDF/SSD-Windows/releases/download/$ssd_windows_version/Shadowsocks-$ssd_windows_version.zip"
unzip ssd-win.zip
rm -rf ssd-win.zip
7za a ssd-win.7z ShadowsocksD.exe
[ -d "ssd-win.7z" ] && mv -f ssd-win.7z ./deploy/ssd-win.7z


sleep 35

# ShadowsocksRR Android

echo "==========================================================================="
echo "* ShadowsocksRR Android"
echo "https://github.com/shadowsocksrr/shadowsocksr-android"

ssrr_android_version=$(get_latest_release "shadowsocksrr/shadowsocksr-android")

echo "Latest Verison: $ssrr_android_version"


wget -o /dev/null -O ssrr-android.apk "https://github.com/shadowsocksrr/shadowsocksr-android/releases/download/$ssrr_android_version/shadowsocksr-android-$ssrr_android_version.apk"
[ -d "ssrr-android.apk" ] && mv -f ssrr-android.apk ./deploy/ssrr-android.apk


sleep 35

# V2RayNG

echo "==========================================================================="
echo "* V2RayNG (Android)"
echo "https://github.com/2dust/v2rayNG"

v2rayng_android_version=$(get_latest_release "2dust/v2rayNG")

echo "Latest Verison: $v2rayng_android_version"


wget -o /dev/null -O v2rayng.apk "https://github.com/2dust/v2rayNG/releases/download/$v2rayng_android_version/app-universal-release.apk"
[ -d "v2rayng.apk" ] && mv -f v2rayng.apk ./deploy/v2rayng.apk