import QtQuick 2.0
import VPlayApps 1.0

Page
{
    id: songoptionpage
    backgroundColor: Qt.rgba(0,0,0, 0.75)
    z: 0
    visible: false
    opacity: 0.0
    Behavior on opacity { NumberAnimation{ duration: 300 } }

    Rectangle
    {
        id: optionRect
        width: parent.width - dp(80)
        height: parent.height - dp(110)
        anchors.centerIn: parent
        color: "#212121"
    }

    AppListView
    {
        id: optioncolumn
        anchors.fill: optionRect
        model: [
            {text: "Play", icon: IconType.play},
            {text: "Playlist", icon: IconType.pluscircle},
            {text: "Delete", icon: IconType.remove},
            {text: "Share", icon: IconType.share}
        ]
        delegate: SimpleRow
                  {
                      style.backgroundColor: "#212121"
                      style.textColor: "white"
                      style.dividerColor: "#616161"
                  }
    }
}
