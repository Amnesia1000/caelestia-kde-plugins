pragma ComponentBehavior: Bound

import QtQuick
import QtMultimedia
import QtCore
import Quickshell

Item {
    id: root

    property ShellScreen screenModel: null
    property string mediaPath: "badapple.mp4"
    property bool playing: true
    property bool audioEnabled: true

    readonly property Item videoOutput: loader.item ? loader.item.videoOutput : null
    readonly property bool isFirstInstance: (!root.screenModel || Quickshell.screens.length <= 1) ? true : (root.screenModel.name === Quickshell.screens[0].name)

    function resolveSource(path: string): url {
        const raw = (path ?? "").trim();
        if (raw.length === 0 || raw === "badapple.mp4")
            return Qt.resolvedUrl("badapple.mp4");
        if (raw.startsWith("~/")) {
            const home = Quickshell.env("HOME") || "";
            return Qt.resolvedUrl("file://" + home + raw.substring(1));
        }
        if (raw.startsWith("file://") || raw.startsWith("http://") || raw.startsWith("https://"))
            return raw;
        if (raw.startsWith("/"))
            return "file://" + raw;
        return Qt.resolvedUrl(raw);
    }

    anchors.fill: parent

    Loader {
        id: loader

        active: root.playing
        anchors.fill: parent

        sourceComponent: Component {
            Item {
                id: videoContainer

                property alias videoOutput: videoOut

                MediaPlayer {
                    id: mediaPlayer

                    source: root.resolveSource(root.mediaPath)
                    videoOutput: videoOut
                    audioOutput: audioOut
                    loops: MediaPlayer.Infinite

                    Component.onCompleted: {
                        if (root.playing)
                            mediaPlayer.play();
                    }

                    onSourceChanged: {
                        if (root.playing)
                            mediaPlayer.play();
                    }

                    onErrorOccurred: (error, errorString) => {
                        console.warn("BadApple MediaPlayer error:", errorString);
                    }
                }

                VideoOutput {
                    id: videoOut

                    anchors.fill: parent
                    fillMode: VideoOutput.Stretch
                }

                AudioOutput {
                    id: audioOut

                    muted: !root.isFirstInstance || !root.audioEnabled
                }
            }
        }
    }
}
