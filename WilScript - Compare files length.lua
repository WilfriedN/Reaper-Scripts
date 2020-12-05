function move()

    reaper.Undo_BeginBlock()
    
    -- LOOP THROUGH SELECTED ITEMS
    line = 0
    itemnumber = 0
    source = 0
    channumber = 0
    selected_items_count = reaper.CountSelectedMediaItems(0)
    stereotrack =  reaper.GetTrack(0,1)
    
    -- INITIALIZE loop through selected items
    for i = 0, selected_items_count-1  do
    -- GET ITEMS
        item = reaper.GetSelectedMediaItem(0, i) -- Get selected item i
        acttake = reaper.GetActiveTake(item)
        takename = reaper.GetTakeName(acttake)
        
        source = reaper.GetMediaItemTake_Source(acttake)
        channumber = reaper.GetMediaSourceNumChannels(source)
        
        if channumber == 2 then
            reaper.ShowConsoleMsg("hi")
            reaper.MoveMediaItemToTrack( item, stereotrack )
            reaper.ShowConsoleMsg(takename.." has "..channumber.." channel(s)\n")
        end
        
        itemnumber = itemnumber +1
       -- end

    end -- ENDLOOP through selected items
    
    reaper.ShowConsoleMsg("\n"..itemnumber.." files analysed\n")
    reaper.Undo_EndBlock("Sort Mono and Stereo files", -1)

end

move()
