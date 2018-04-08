function playThis(index, row)
{
    setPlayingIcon()
    songRow = row
    mainplaylist.currentIndex = index
    batplayer.play()
    console.log("pt= "+index)
}

function setPlayingIcon()
{
    if(songRow !== undefined)
    {
        songRow.iconSource = IconType.music
    }
}

function playPrevTrack()
{
    mainplaylist.previous()
    console.log("prev song...")
}

function playNextTrack()
{
    mainplaylist.next()
    console.log("Next song...")
}

function playOrPause()
{
    if(batplayer.playbackState === Audio.PlayingState)
    {
        batplayer.pause()
    }
    else
    {
        batplayer.play()
    }
}

function calculateRemTime(position)
{
    var totalDurSec = Math.floor(position / 1000)
    var min = Math.floor(totalDurSec/60)
    if(min < 10)
        min = "0"+min
    var sec = Math.floor(totalDurSec%60)
    if(sec < 10)
        sec = "0"+sec
    var time = min + ":" + sec
    remTime = time
    // set slider position
    updateSongSlider(position)
}

function calculateTotalTime(duration)
{
    var totalDurSec = Math.floor(duration / 1000)
    var min = Math.floor(totalDurSec/60)
    if(min < 10)
        min = "0"+min
    var sec = Math.floor(totalDurSec%60)
    if(sec < 10)
        sec = "0"+sec
    var time = min + ":" + sec
    totalTime = time
    totalDuration = totalDurSec
}

function updateSongSlider(pos)
{
    pos = pos/1000
    playingpage.sliderValue = pos/totalDuration
}

function setSongPosition(pos)
{
    var offset = totalDuration*1000*pos
    batplayer.seek(offset)
}

function songChanged(src)
{
    //var srcstr = src.toString()
    //var li = srcstr.lastIndexOf("/")
    //var mp3 = srcstr.slice(++li);
    var mp3 = mediaextractorId.getTitle(src)
    currentSongName = mp3
    playingpage.title = mp3

    currentSongIndex = mainplaylist.currentIndex
}

function setRepeatShuffle(mode)
{
    switch (mode)
    {
        // shuffle on
        case randomMode:
            shuffleOn = true
            repeatAll = repeatOne = allOff = false
            break

        // repeat All songs
        case repeatAllMode:
            repeatAll = true
            shuffleOn = repeatOne = allOff =  false
            break

        // repeat current song
        case repeatCurrentMode:
            repeatOne = true
            repeatAll = shuffleOn = allOff = false
            break

        // play in sequence
        case sequentialMode:
            allOff = true
            repeatAll = repeatOne = shuffleOn = false
            break

        default:
            console.log("ERROR IN MODE")
    }
}

function setPlayPauseIcon(flag)
{
    if(flag) // playing
        pIcon = pauseIcon
    else // paused
        pIcon = playIcon
}

function check()
{
    var status = database.getValue("firstTime")
    if(status === undefined)
    {
        database.setValue("firstTime", false)
    }
    else
    {
        isFirstTime = false
        restorePrevious()
    }
}

function restorePrevious()
{
    if( ! isFirstTime )
    {
        mainplaylist.currentIndex = database.getValue("index")
        mainplaylist.playbackMode = database.getValue("playbackMode")
        batplayer.seek(database.getValue("position"))
        var playlistNames = database.getValue("playlistNames")
        if(playlistNames !== undefined)
        {
            //for(var i=0; i<playlistNames.length; ++i)
        }
    }
}

function saveData()
{
    database.setValue("index", currentSongIndex)
    database.setValue("position", batplayer.position)
    database.setValue("playbackMode", mainplaylist.playbackMode)
}

function searchSong(text)
{
    if(text !== "")
    {
        //songsearchMenu.open()
        for(var i=0; i<allSongModel.count; ++i)
        {
            var itm = allSongModel.get(i)
            if(itm.fileName.search(text) !== -1)
            {
                allSongModel.clear()
                mainplaylist.clear()
                for(var j=0; tempModel.count; ++j)
                {
                    var titm = tempModel.get(j)
                    if(titm.fileName.search(text) !== -1)
                    {
                        allSongModel.append(titm)
                    }
                }
            }
        }
    }
    else
    {
        allSongModel.clear()
        mainplaylist.clear()
        for(var i=0; i<tempModel.count; ++i)
        {
            allSongModel.append(tempModel.get(i))
        }
        //songsearchMenu.close()
    }
}

function removeFromTempModel(index)
{
    tempModel.remove(index)
}

function handleSongOption(index)
{
    if(index === 0) // play option clicked
    {
        console.log("play option")
        mainplaylist.currentIndex = selectedSongIndex
        batplayer.play()
    }

    if(index === 1) // Add to playlist option clicked
    {
        console.log("Add to playlist option")
        playlistoption.open()
    }

    if(index === 2) // Share option clicked
    {
        console.log("Share option")
        nativeUtils.share("Share song with",selectedSongPath)
    }

    if(index === 3) // delete option clicked
    {
        console.log("delete option")
        if(mainplaylist.removeItem(selectedSongIndex) && removeId.deleteFile(selectedSongPath))
        {
            allSongModel.remove(selectedSongIndex)
            LOGIC.removeFromTempModel(selectedSongIndex)
        }
    }
}

function createNewPlaylist(enteredText)
{
    if(enteredText !== "")
    {
        playlistModel.append({"plOption":enteredText})
        var tmpSongList = database.getValue(enteredText)
        var tmpSongListPath = database.getValue(enteredText+"pl")
        if(tmpSongList === undefined && tmpSongListPath === undefined)
        {
            var songList = [selectedSongName]
            var songListPath = [selectedSongPath]
            database.setValue(enteredText, songList)
            database.setValue(enteredText+"pl",songListPath)
        }
        var tmpList = database.getValue("playlistNames")
        if(tmpList === undefined)
        {
            var playlistNames = [enteredText]
            database.setValue("playlistNames",playlistNames)
        }
        else
        {
            tmpList.push(enteredText)
            database.clearValue("playlistNames")
            database.setValue("playlistNames",tmpList)
        }
    }
}

function addToThisPlaylist(plName)
{
    var songList = database.getValue(plName)
    var songListPath = database.getValue(plName+"pl")

    if(songList !== undefined)
    {
        songList.push(selectedSongName)
        database.clearValue(plName)
        database.setValue(plName,songList)
    }
    if(songListPath !== undefined)
    {
        songListPath.push(selectedSongPath)
        database.clearValue(plName+"pl")
        database.setValue(plName+"pl",songListPath)
    }
}

function openPlaylist(plName)
{
    playlistsongpage.title = plName
    var songList = database.getValue(plName)
    var songListPath = database.getValue(plName+"pl")

    if(songList !== undefined && songListPath !== undefined)
    {
        playlistSongModel.clear()
        for(var i=0; i<songList.length; ++i)
        {
            var file = songList[i]
            var filePath = songListPath[i]
            playlistSongModel.append({"fileName":file,"fileURL":filePath})
        }
    }

    playlistsongpage.songModel = playlistSongModel
    navigationStack.push(playlistsongpage)
}

function checkGesture(gesture)
{
    if(gesture === "shakeLeft")
        playPrevTrack()
    if(gesture === "shakeRight")
        playNextTrack()
    if(gesture === "shakeDown")
        playOrPause()
}

function setRotation()
{
    // starts rotation of Music C.D
    if(batplayer.playbackState === Audio.PlayingState)
        playingpage.startAnimation = true
    // stops rotation of Music C.D
    if(batplayer.playbackState === Audio.PausedState)
        playingpage.startAnimation = false
}
