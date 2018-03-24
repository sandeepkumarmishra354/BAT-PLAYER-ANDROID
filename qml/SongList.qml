import QtQuick 2.0
import Qt.labs.folderlistmodel 2.2
import VPlayApps 1.0
import QtMultimedia 5.8

AppListView
{
    id: listview
    focus: true
    signal songIndex(int index, var row)
    signal songPath(string path)
    readonly property string androidPath: "file:///sdcard/Music"
    readonly property string linuxPath: "/root/Music"
    property bool optionRaised: false

    FolderListModel
    {
        id: foldermodel
        showDirs: false
        caseSensitive: false
        folder: linuxPath
        nameFilters: ["*.mp3","*.wav","*.mp4a","*.ogg"]
    }
    model: foldermodel
    delegate: SimpleRow
              {
                  property string fullpath
                  text: fileName
                  fullpath: fileURL
                  iconSource: IconType.music
                  style.backgroundColor: "#66ffff"
                  style.dividerColor: "#009999"
                  Component.onCompleted: { listview.songPath(fullpath) }
                  MouseArea
                  {
                      id: pressarea
                      anchors.fill: parent
                      onPressAndHold:
                      {
                          //console.log("press and hold")
                          option.z = 1
                          option.visible = true
                          option.opacity = 1.0
                          optionRaised = true
                      }

                      onClicked:
                      {
                          listview.songIndex(index, parent)
                          iconSource = IconType.play
                      }
                  }
              }
    backgroundColor: "#66ffff"
    emptyText.text: "No Items"

    SongOptions
    {
        id: option
    }
    Keys.onBackPressed:
    {
        if(optionRaised)
        {
            option.z = 0
            option.visible = false
            option.opacity = 0.0
            optionRaised = false
        }
    }
}
