import QtQuick
import QtQuick.Layouts
import Caelestia.Config
import qs.components
import qs.services
import qs.utils

Item {
    id: root

    property var bar: null

    readonly property bool active: GameMode.enabled || detect.feralActive
    readonly property color onColour: "#4ade80"

    // Game mode is off most of the time, so the widget only takes a slot while
    // it is actually doing something.
    visible: active
    implicitWidth: visible ? icon.implicitWidth + Tokens.padding.small * 2 : 0
    readonly property int thickness: (bar && (bar.thickness || bar.barThickness)) ? (bar.thickness || bar.barThickness) : Tokens.sizes.bar.innerWidth

    implicitHeight: root.thickness


    GameModeDetect {
        id: detect
    }

    MaterialIcon {
        id: icon

        anchors.centerIn: parent
        text: "gamepad"
        color: root.onColour
        fontStyle: Tokens.font.icon.small
    }
}
