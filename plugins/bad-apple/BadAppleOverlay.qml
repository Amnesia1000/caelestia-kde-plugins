pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtCore
import Quickshell
import Caelestia.Config
import qs.services

Item {
    id: root

    property ShellScreen screen: null
    property var modelData: screen

    anchors.fill: parent

    Settings {
        id: pluginSettings

        category: "Plugin_bad-apple"
        property string mediaPath: "badapple.mp4"
        property bool playing: true
        property bool audioEnabled: true
    }

    Item {
        id: badAppleMaskContainer

        anchors.fill: parent
        layer.enabled: pluginSettings.playing
        layer.effect: pluginSettings.playing ? badAppleShaderComponent : null

        Rectangle {
            anchors.fill: parent
            color: (typeof GlobalConfig !== "undefined" && GlobalConfig.appearance?.pitchBlack) ? "#000000" : Colours.palette.m3surface
            visible: pluginSettings.playing
            opacity: 1.0
        }
    }

    BadAppleVideo {
        id: badAppleMaskSource

        screenModel: root.screen
        mediaPath: pluginSettings.mediaPath
        playing: pluginSettings.playing
        audioEnabled: pluginSettings.audioEnabled
        anchors.fill: parent
        opacity: 0.0
    }

    Component {
        id: badAppleShaderComponent

        ShaderEffect {
            property variant mask: ShaderEffectSource {
                sourceItem: badAppleMaskSource.videoOutput
                hideSource: true
            }
            property real videoRatio: {
                if (badAppleMaskSource.videoOutput && badAppleMaskSource.videoOutput.sourceRect.height > 0)
                    return badAppleMaskSource.videoOutput.sourceRect.width / badAppleMaskSource.videoOutput.sourceRect.height;
                return 16.0 / 9.0;
            }
            property real screenRatio: root.width / Math.max(1.0, root.height)

            fragmentShader: Qt.resolvedUrl("badapple.frag.qsb")
        }
    }
}
