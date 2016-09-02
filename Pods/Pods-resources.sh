#!/bin/sh
set -e

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1"`.mom\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd"
      ;;
    *.xcassets)
      ;;
    /*)
      echo "$1"
      echo "$1" >> "$RESOURCES_TO_COPY"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
install_resource "Appirater/ca.lproj"
install_resource "Appirater/cs.lproj"
install_resource "Appirater/da.lproj"
install_resource "Appirater/de.lproj"
install_resource "Appirater/el.lproj"
install_resource "Appirater/en.lproj"
install_resource "Appirater/es.lproj"
install_resource "Appirater/fi.lproj"
install_resource "Appirater/fr.lproj"
install_resource "Appirater/he.lproj"
install_resource "Appirater/hu.lproj"
install_resource "Appirater/it.lproj"
install_resource "Appirater/ja.lproj"
install_resource "Appirater/ko.lproj"
install_resource "Appirater/nb.lproj"
install_resource "Appirater/nl.lproj"
install_resource "Appirater/pl.lproj"
install_resource "Appirater/pt.lproj"
install_resource "Appirater/ro.lproj"
install_resource "Appirater/ru.lproj"
install_resource "Appirater/sk.lproj"
install_resource "Appirater/sv.lproj"
install_resource "Appirater/tr.lproj"
install_resource "Appirater/zh-Hans.lproj"
install_resource "Appirater/zh-Hant.lproj"
install_resource "DVAdKit/DVAdKit.podspec"
install_resource "DVAdKit/Resources/DVAdKit.bundle"
install_resource "DVAdKit/Resources/DVAdKit.bundle"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/fiksu-bar-1.png"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/fiksu-close-debug.png"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/fiksu-config.png"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/fiksu-event-failed.png"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/fiksu-event-succeeded.png"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/fiksu-event.png"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/fiksu-icon.png"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/fiksu-verify.png"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/FMConfigViewController.nib/objects.nib"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/FMConfigViewController.nib/runtime.nib"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/FMEventsViewController.nib/objects.nib"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/FMEventsViewController.nib/runtime.nib"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/FMTrackingViewController.nib/objects.nib"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/FMTrackingViewController.nib/runtime.nib"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/FMVerifyViewController.nib/objects.nib"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/FMVerifyViewController.nib/runtime.nib"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/FMConfigViewController.nib"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/FMEventsViewController.nib"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/FMTrackingViewController.nib"
install_resource "Fiksu-iOS-SDK/FiksuSDK.embeddedframework/FiksuSDK.framework/Versions/A/Resources/FMVerifyViewController.nib"
install_resource "NFLibrary/NFLibrary.podspec"
install_resource "NFLibrary/Resources/NFUIKit/NFAnimationResources.bundle"
install_resource "NFLibrary/Resources/NFUIKit/NFViewControllersResources.bundle"
install_resource "NFLibrary/Resources/NFUIKit/NFViewsResources.bundle"
install_resource "VungleAdvertiserSDK/VungleSDK.embeddedframework/Resources/__vungle.db"
install_resource "VungleAdvertiserSDK/VungleSDK.embeddedframework/Resources/vg_close.png"
install_resource "VungleAdvertiserSDK/VungleSDK.embeddedframework/Resources/vg_cta.png"
install_resource "VungleAdvertiserSDK/VungleSDK.embeddedframework/Resources/vg_mute_off.png"
install_resource "VungleAdvertiserSDK/VungleSDK.embeddedframework/Resources/vg_mute_on.png"
install_resource "VungleAdvertiserSDK/VungleSDK.embeddedframework/Resources/vg_timer.png"

rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ `xcrun --find actool` ] && [ `find . -name '*.xcassets' | wc -l` -ne 0 ]
then
  case "${TARGETED_DEVICE_FAMILY}" in 
    1,2)
      TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
      ;;
    1)
      TARGET_DEVICE_ARGS="--target-device iphone"
      ;;
    2)
      TARGET_DEVICE_ARGS="--target-device ipad"
      ;;
    *)
      TARGET_DEVICE_ARGS="--target-device mac"
      ;;  
  esac 
  find "${PWD}" -name "*.xcassets" -print0 | xargs -0 actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${IPHONEOS_DEPLOYMENT_TARGET}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
