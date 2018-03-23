function playThis(index, songName, row)
{
    setPlayingIcon()
    songRow = row
    batplayer.source = mainplaylist.itemSource(index)
    batplayer.play()
    currentSongName = songName
    playingpage.title = songName
    currentSongIndex = index
}

function setPlayingIcon()
{
    if(songRow != undefined)
    {
        songRow.iconSource = IconType.music
    }
}

function currentRow(curindex)
{
    return mainPage.returnRow(curindex)
}
