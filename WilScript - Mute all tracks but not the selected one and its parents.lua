function mute()

    reaper.Undo_BeginBlock()
    
    --selected track count. if 0 get out of here
    local sel_tr_count = reaper.CountSelectedTracks(0)
    if sel_tr_count == 0 then
       return
    end
    
    reaper.MuteAllTracks(true)
    
    for i = 0, sel_tr_count-1  do
        tr = reaper.GetSelectedTrack(0,i)
        reaper.SetMediaTrackInfo_Value(tr, "B_MUTE", 0)
        parentTrack = reaper.GetParentTrack(tr)
        if parentTrack ~= nil then
            repeat
                tr = parentTrack
                reaper.SetMediaTrackInfo_Value(tr, "B_MUTE", 0)
                parentTrack = reaper.GetParentTrack(tr)
           until parentTrack == nil
        end
    end
    
    reaper.Undo_EndBlock("Mute all but selected tracks and parents", -1)

end

mute()
