import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.0
import QtQuick.Controls 1.4
import QtMultimedia 5.8
import QtQuick.Window 2.3
import QtQml 2.2
import QtSensors 5.9
import RemoveFile 1.0 // c++ class
import MediaExtractor 1.0 // c++ class
import "AppLogic.js" as LOGIC

App {
    id: root
    licenseKey: propertycontainer.licenseKeyString

    // model of main song list
    ListModel { id: allSongModel }

    // model of playlist names
    ListModel { id: playlistModel }

    // model of playlist songs
    ListModel { id: playlistSongModel }

    // temp model for backup
    ListModel { id: tempModel }

    // contains all variables
    PropertyContainer { id: propertycontainer; anchors.fill: parent }

    // database
    Storage { id: database; clearAllAtStartup: true }

    // delete song by this (implemented in C++)
    RemoveFile { id: removeId }

    // extract album cover art by this (implemented in C++ using taglib)
    MediaExtractor { id: mediaextractorId }

    // main playing page
    SongPlayerPage { id: playingpage }

    // playlist song container page
    PlaylistSongPage { id: playlistsongpage}

    // timer popup menu (sleep timer)
    TimerMenu
    {
        id: timermenu
        x: propertycontainer.xAxis
        y: propertycontainer.yAxix
        width: propertycontainer.opWidth
        height: propertycontainer.opHeight
    }

    onInitTheme:
    {
        Theme.navigationBar.backgroundColor = propertycontainer.darkColor
        Theme.tabBar.backgroundColor = propertycontainer.darkColor
        Theme.tabBar.titleOffColor = propertycontainer.lightGrey
        Theme.colors.textColor = propertycontainer.textColor
        Theme.navigationAppDrawer.textColor = propertycontainer.drowerTextColor
        Theme.navigationAppDrawer.activeTextColor = propertycontainer.textColor
        Theme.navigationAppDrawer.backgroundColor = propertycontainer.darkColor
        Theme.navigationAppDrawer.itemBackgroundColor = propertycontainer.darkColor
        Theme.navigationAppDrawer.dividerColor = propertycontainer.darkColor
        Theme.colors.scrollbarColor = propertycontainer.scrollBarColor
    }

    Navigation
    {
        id: mainNav
        NavigationItem
        {
            id: songsItem
            title: "Songs"
            icon: IconType.music
            NavigationStack
            {
                id: navigationStack
                SongPage { id: mainPage }
            }
        }

        NavigationItem
        {
            id: aboutNavItem
            icon: IconType.info
            title: "Info"
            NavigationStack
            {
                id: aboutNavStack
                AboutPage { id: aboutpage }
            }
        }

        NavigationItem
        {
            id: settingsNavItem
            icon: IconType.cogs
            title: "Settings"
            NavigationStack
            {
                id: settingsNavStack
                SettingPage { id: settngpage }
            }
        }
    }

    Playlist
    {
        id: mainplaylist
        playbackMode: propertycontainer.repeatAllMode
        onCurrentIndexChanged:{
            console.log(currentItemSource)
            LOGIC.songChanged(currentItemSource)
            propertycontainer.currentPlayingArtist = mediaextractorId.getArtist(currentItemSource)
            var cvr = mediaextractorId.getTitle(currentItemSource)
            var art = mediaextractorId.getAlbumCover(cvr)
            if(art !== "")
            {

                propertycontainer.coverArt = art
                propertycontainer.ifCoverArt = true
            }
            else
            {
                propertycontainer.coverArt = propertycontainer.defaultCoverArt
                propertycontainer.ifCoverArt = false
            }
        }
        onPlaybackModeChanged: LOGIC.setRepeatShuffle(playbackMode)
    }

    MediaPlayer
    {
        id: batplayer
        playlist: mainplaylist
        onPositionChanged: LOGIC.calculateRemTime(position)
        onDurationChanged: LOGIC.calculateTotalTime(duration)
        onPaused: LOGIC.setPlayPauseIcon(false)
        onPlaying: LOGIC.setPlayPauseIcon(true)
        onPlaybackStateChanged: LOGIC.setRotation()
    }

    SensorGesture
    {
        id: gestureSensor
        enabled: (Qt.platform.os == "android" ? true : false)
        gestures: ["QtSensors.shake2"]
        onDetected: LOGIC.checkGesture(gesture)
    }

    onSplashScreenFinished: LOGIC.check()
    onClosing: LOGIC.saveData()
}
