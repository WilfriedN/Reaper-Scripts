
-- REQUIREMENTS:
-- ° Create a CSV with all the file paths in column A
-- ° Create an empty track with the processing you want as its FX chain
-- ° Set the render source in the Render window to "Selected media items via master"

function SplitFilename(strFilename)
	-- Returns the Path (excluding filename), Filename (with extension), and Extension as 3 values
	return string.match(strFilename, "(.-)([^\\]-([^\\%.]+))$")
end

----------------------------------------------------------------------

function read_lines(filepath)
  
  reaper.Undo_BeginBlock() -- Begin undo group
  
	nboflines = 0
	local f = io.input(filepath)
    
  repeat
    
    s = f:read ("*l") -- read one line
    if s then  -- if not end of file (EOF)
		
	i = 0
	linecpt = 0
	stringcut = {}
	filepath = ""
	filepathcopy = ""

	for token in string.gmatch(s, "[^,]+") do
		stringcut[linecpt] = token
		linecpt = linecpt+1
	end
      
	filepath = stringcut[0]
	-- filepathcopy = filepath:gsub("Test","COPY_test")
	-- command = "copy "..filepath.." "..filepathcopy
	
	-- os.execute(command)    
	
	
	track = reaper.GetTrack(0,0)
	reaper.SetOnlyTrackSelected(track)
	reaper.InsertMedia(filepath,0)
	
	nbitems = reaper.CountMediaItems(0)
	currentitemID = nbitems-1
	item = reaper.GetMediaItem(0,currentitemID)
		
	reaper.Main_OnCommand(40289,0) -- Unselect all items
	reaper.SetMediaItemSelected(item,1)
	
	filepathcopy = filepath:gsub(".wav","_copy.wav")
	path,file,extension = SplitFilename(filepath)
	pathcopy,filecopy,extensioncopy = SplitFilename(filepathcopy)
	-- reaper.ULT_SetMediaItemNote(item, path)
	-- reaper.GetSetProjectInfo(0,"RENDER_SETTINGS ",64,true)
	reaper.GetSetProjectInfo_String(0, 'RENDER_FILE', path, true)
	reaper.GetSetProjectInfo_String(0, 'RENDER_PATTERN', filecopy, true)
	
	reaper.Main_OnCommand(42230,0) -- Render
	
	reaper.DeleteTrackMediaItem( reaper.GetMediaItemTrack(item), item )
	os.execute("del /f \""..filepath.."\"") 
	
	filepathpeaks = filepath..".reapeaks"
	os.execute("del /f \""..filepathpeaks.."\"")
	
	command = "rename \""..filepathcopy.."\" \""..file.."\""
	os.execute(command)
    end
  
	until not s  -- until end of file
  
	
	f:close()

	reaper.Undo_EndBlock("Display script infos in the console", -1) -- End undo group
  
end



-- START -----------------------------------------------------
retval, filetxt = reaper.GetUserFileNameForRead("", "Import assets", "csv")

if retval then 
  
  reaper.PreventUIRefresh(1)
  read_lines(filetxt)
  
-- Update TCP
  reaper.TrackList_AdjustWindows(false)
  reaper.UpdateTimeline()
  
  reaper.UpdateArrange()
  reaper.PreventUIRefresh(-1)
  
end