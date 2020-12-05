function adjust()

    reaper.Undo_BeginBlock()
    
    -- LOOP THROUGH SELECTED ITEMS
    itemnumber = 0
    selected_items_count = reaper.CountSelectedMediaItems(0)
    volume = 0
    RMS = 0
        
        for i = 0, selected_items_count-1  do
             -- GET ITEMS
            item = reaper.GetSelectedMediaItem(0, i) -- Get selected item i
            acttake = reaper.GetActiveTake(item)
            takename = reaper.GetTakeName(acttake) 
           
            stringcut = {}
            linecpt = 0
        
            RMS = reaper.NF_GetMediaItemAverageRMS(item)
            volume =  reaper.GetMediaItemInfo_Value(item, 'D_VOL')
            reaper.ShowConsoleMsg("OLD\n"..takename..":\n- RMS: "..RMS.."\n- Volume: "..volume.."\n\n")
            volume = 2^(10/6)
            reaper.SetMediaItemTakeInfo_Value(acttake,'D_VOL',volume)
            RMS = reaper.NF_GetMediaItemAverageRMS(item)
            reaper.ShowConsoleMsg("NEW\n"..takename..":\n- RMS: "..RMS.."\n- Volume: "..volume.."\n\n\n")
        
            itemnumber = itemnumber +1
        
        end
          
    reaper.ShowConsoleMsg("\n"..itemnumber.." files modified")
    reaper.Undo_EndBlock("Adjust Volume", -1)

end

reaper.PreventUIRefresh(1)
adjust()
reaper.TrackList_AdjustWindows(false)
reaper.UpdateTimeline()

reaper.UpdateArrange()
reaper.PreventUIRefresh(-1)