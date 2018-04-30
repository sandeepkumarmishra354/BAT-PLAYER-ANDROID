import QtQuick 2.9
import QtQuick.Controls 2.2
import VPlayApps 1.0
import "JS/AppLogic.js" as LOGIC

Menu
{
    id: mainParent
    opacity: 0.0
    Behavior on opacity {
        NumberAnimation{duration: 400}
    }

    background: Rectangle
    {
        color: propertycontainer.darkColor
        AppListView
        {
            id: list
            anchors.fill: parent
            model: [
                {text: "Play", icon: IconType.play},
                {text: "Add to playlist", icon: IconType.pluscircle},
                {text: "Share", icon: IconType.share},
                {text: "Delete", icon: IconType.remove},
                {text: "Add to queue", icon: IconType.forward}
            ]
            delegate: SimpleRow
            {
                style.backgroundColor: propertycontainer.darkColor
                style.dividerColor: propertycontainer.listDividerColor
                visible: (index == 1 ? false : true)
                onSelected:
                {
                    if(index == 3)
                    {
                        nativeUtils.displayAlertDialog("Delete","Are you sure ?","Delete","Cancel")
                        mainParent.close()
                    }
                    else
                    {
                        LOGIC.handleSongOption(index)
                        mainParent.close()
                    }
                }
            }
        }
    }
    Connections
    {
        target: nativeUtils
        onAlertDialogFinished:
        {
            if(accepted)
                LOGIC.handleSongOption(3)
        }
    }

    onOpened: { opacity = 1.0 }
    onClosed: { opacity = 0.0 }

    PlaylistOption
    {
        id: playlistoption
        y: yAxix
        x: xAxis
        width: opWidth
        height: opHeight
    }
}
