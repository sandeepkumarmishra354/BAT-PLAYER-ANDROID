import QtQuick 2.9
import QtQuick.Controls 2.2
import VPlayApps 1.0
import "AppLogic.js" as LOGIC

Menu
{
    id: mainMenu
    //opacity: 0.0
    Behavior on opacity {
        NumberAnimation{duration: 200}
    }

    background: Rectangle
    {
        color: propertycontainer.darkColor
        AppListView
        {
            id: songsearchlist
            anchors.fill: parent
            model: []
            delegate: SimpleRow { }
        }
    }

    onOpened: { opacity = 1.0 }
    onClosed: { opacity = 0.0 }
}
