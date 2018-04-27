import QtQuick 2.0
import Qt.labs.folderlistmodel 2.2
import VPlayApps 1.0
import QtMultimedia 5.8

AppListView
{
    id: listview
    signal songIndex(int index, var row)
    signal songPath(string path)
    readonly property string nomusicText: "<b>Place your music files to internal storage's Music folder</b>"
    property real xAxis: (width - optionMenu.width)/2
    property real yAxix: (height - optionMenu.height)/2
    property real opWidth: (width) - (width/5)
    property real opHeight: height/2
    property real tabletSize: sp(35)
    property real mobileSize: 0.0

    AppActivityIndicator
    {
        anchors.centerIn: parent
        animating: propertycontainer.isLoading
        hidesWhenStopped: true
    }

    model: allSongModel
    delegate: SimpleRow
              {
                  id: simplerowDel
                  property string fullpath
                  text: fileName.toString()
                  detailText: artist
                  fullpath: fileURL
                  iconSource: IconType.music
                  style.backgroundColor: Qt.rgba(0,0,0, 0.45)
                  style.dividerColor: propertycontainer.listDividerColor
                  style.detailTextColor: propertycontainer.detailTextColor
                  style.fontSizeDetailText:
                  {
                      if(Qt.platform.os !== "android")
                      {
                        if(tablet)
                            return sp(20)
                        else
                            return sp(15)
                      }
                  }
                  //visible: ( index == 3 ? true : false )
                  height: dp(70)
                  Component.onCompleted:
                  {
                      listview.songPath(fullpath)
                      mobileSize = style.fontSizeText
                  }
                  RippleMouseArea
                  {
                      id: pressarea
                      anchors.fill: parent
                      centerAnimation: true
                      pressedDuration: 800
                      circularBackground: false
                      onPressAndHold:
                      {
                          console.log("press and hold")
                          propertycontainer.selectedSongIndex = index
                          propertycontainer.selectedSongPath = fullpath
                          propertycontainer.selectedSongName = text
                          optionMenu.open()
                      }

                      onClicked:
                      {
                          listview.songIndex(index, parent)
                          iconSource = IconType.play
                      }
                  }
              }

    //opacity: 0.7
    emptyText.text: nomusicText
    emptyText.color: "purple"

    SongOptions
    {
        id: optionMenu
        y: yAxix
        x: xAxis
        width: opWidth
        height: opHeight
    }
}
