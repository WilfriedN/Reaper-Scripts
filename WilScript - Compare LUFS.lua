function time()

    reaper.Undo_BeginBlock()
    local f = io.open("/Users/sounding.sweet/Desktop/testLUFS/lufstemp.txt", "w")
    io.output(f)
    
    -- LOOP THROUGH SELECTED ITEMS
    line = 0
    itemnumber = 0
    selected_items_count = reaper.CountSelectedMediaItems(0)
    --line = "Name,Worked?,LUFS Integrated,True Peak,Momentary Max Value\n"
    line = "Name,Worked?,LUFS Integrated\n"
    io.write(line)
    
    -- INITIALIZE loop through selected items
    for i = 0, selected_items_count-1  do
    -- GET ITEMS
        item = reaper.GetSelectedMediaItem(0, i) -- Get selected item i
        acttake = reaper.GetActiveTake(item)
        takename = reaper.GetTakeName(acttake)   
        --if acttake then
            --retval, lufsIntegrated, range, truePeak, truePeakPos, shortTermMax, momentaryMax = reaper.NF_AnalyzeTakeLoudness( acttake, false )
            --line = takename..","..tostring(retval)..","..lufsIntegrated..","..truePeak..","..momentaryMax..",".."\n"
            --retval, lufsIntegrated = reaper.NF_AnalyzeTakeLoudness_IntegratedOnly(acttake)
            --line = takename..","..tostring(retval)..","..lufsIntegrated.."\n"
            line = takename..","..tostring(reaper.NF_GetMediaItemAverageRMS(item)).."\n"
            io.write(line)
            itemnumber = itemnumber +1
       -- end

    -- totaltime = totaltime + reaper.GetMediaItemInfo_Value(item,"D_LENGTH")

    end -- ENDLOOP through selected items
    
    io.close(f)
    reaper.ShowConsoleMsg(itemnumber.." entries added to lufstemp.txt")
    reaper.Undo_EndBlock("Compare LUFS", -1)

end

time()