hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="yaro"

function! s:setfg(group, color) 
    exe "highlight " . a:group . " gui=NONE cterm=NONE term=NONE guibg=NONE guifg=" . a:color
endfunction

function! s:setbgfg(group, color_bg, color_fg) 
    exe "highlight " . a:group . " gui=NONE cterm=NONE term=NONE guibg= " . a:color_bg . " guifg=" . a:color_fg
endfunction

function! yaroscheme#apply()
if &background == "dark"
    let s:bg_default = "#181818"
    let s:bg_secondary = "#494949"
    let s:bg_highlight = "#302f2b"
    let s:bg_select = "#424f59"
    let s:bg_green = "#263f23"
    let s:bg_red = "#3f0909"

    let s:bg_almost_invisible = "#202020"
    let s:text_invisible_chars = "#303030"

    let s:text_normal = "#fffff"
    let s:text_on_bg = "#e5e5e5"
    let s:text_green = "#b0e5ac"
    let s:text_blue = "#accde5"
    let s:text_brown = "#ccb484"
    let s:text_red = "#a51818"
    let s:text_yellow = "#e5e5ac"
    let s:text_gray = "#7f7f7f"
    let s:text_purple = "#9B2393"
else
    let s:bg_default = "#ffffff"
    let s:bg_secondary = "#cccccc"
    let s:bg_highlight = "#a2bfd8"
    let s:bg_select = "#cee2f2"
    let s:bg_green = "#46a53a"
    let s:bg_red = "#a53a3a"

    let s:bg_almost_invisible = "#fcfcfc"
    let s:text_invisible_chars = "#eaeaea"

    let s:text_normal = "#262626"
    let s:text_on_bg = "#ffffff"
    let s:text_green = "#197211"
    let s:text_blue = "#23608c"
    let s:text_brown = "#725011"
    let s:text_red = "#bf1c1c"
    let s:text_yellow = "#727211"
    let s:text_gray = "#595959"
    let s:text_purple = "#9B2393"
endif

call s:setbgfg("Normal", s:bg_default, s:text_normal)
call s:setbgfg("NormalNC", s:bg_default, s:text_normal)
call s:setfg("Comment", s:text_gray)
call s:setfg("Constant", s:text_normal)
call s:setfg("Identifier", s:text_normal)
call s:setfg("Special", s:text_normal)
call s:setfg("Ignore", s:text_normal)
call s:setfg("Underlined", s:text_normal)
call s:setfg("Todo", s:text_yellow)
call s:setfg("Statement", s:text_blue)
call s:setfg("Type", s:text_blue)
call s:setfg("PreProc", s:text_brown)
call s:setfg("Error", s:text_red)

call s:setfg("String", s:text_green)
call s:setfg("Character", s:text_yellow)
call s:setfg("Include", s:text_green)
call s:setfg("Operator", s:text_normal)
call s:setfg("SpecialChar", s:text_normal)
call s:setfg("Delimiter", s:text_normal)
call s:setfg("Structure", s:text_yellow)
call s:setfg("Function", s:text_yellow)
call s:setfg("Typedef", s:text_yellow)
call s:setfg("StorageClass", s:text_yellow)
call s:setfg("Number", s:text_blue)
call s:setfg("Boolean", s:text_blue)
call s:setfg("Float", s:text_blue)
call s:setfg("Conditional", s:text_blue)
call s:setfg("Repeat", s:text_blue)
call s:setfg("Keyword", s:text_blue)
call s:setfg("PreCondit", s:text_blue)
call s:setfg("Define", s:text_brown)
call s:setfg("Label", s:text_brown)
call s:setfg("Macro", s:text_brown)

call s:setfg("LineNr", s:text_yellow)
call s:setfg("Directory", s:text_blue)
call s:setfg("LineNrAbove", s:text_gray)
call s:setfg("LineNrBelow", s:text_gray)

call s:setbgfg("Search", s:bg_select, s:text_normal)
call s:setbgfg("IncSearch", s:bg_red, s:text_on_bg)
call s:setbgfg("EndOfBuffer", s:bg_default, s:text_normal)

call s:setfg("ErrorMsg", s:text_red)

call s:setbgfg("QuickFixLine", s:bg_highlight, s:text_normal)

call s:setbgfg("Visual", s:bg_select, s:text_normal)
call s:setbgfg("VisualNOS", s:bg_select, s:text_normal)

call s:setbgfg("Pmenu", s:bg_default, s:text_normal)
call s:setbgfg("PmenuExtra", s:bg_default, s:text_normal)
call s:setbgfg("PmenuSbar", s:bg_default, s:text_normal)
call s:setbgfg("PmenuKind", s:bg_default, s:text_normal)

call s:setbgfg("DiffAdd", s:bg_green, s:text_on_bg)
call s:setbgfg("DiffAdd", s:bg_green, s:text_on_bg)
call s:setbgfg("DiffChange", s:bg_green, s:text_on_bg)
call s:setbgfg("DiffDelete", s:bg_red, s:text_on_bg)
call s:setbgfg("DiffText", s:bg_default, s:text_normal)

call s:setbgfg("DiffFile", s:bg_highlight, s:text_on_bg)
call s:setbgfg("DiffIndexLine", s:bg_secondary, s:text_on_bg)
call s:setbgfg("DiffOldFile", s:bg_secondary, s:text_on_bg)
call s:setbgfg("DiffNewFile", s:bg_secondary, s:text_on_bg)
call s:setbgfg("DiffLine", s:bg_secondary, s:text_normal)
call s:setbgfg("DiffSubname", s:bg_secondary, s:text_normal)

" Git fugitive colors
call s:setbgfg("diffAdded", s:bg_green, s:text_on_bg)
call s:setbgfg("diffRemoved", s:bg_red, s:text_on_bg)

" Merge conflict highlighting
call s:setbgfg("ConflictMarkerOurs", s:bg_green, s:text_on_bg)
call s:setbgfg("ConflictMarkerTheirs", s:bg_red, s:text_on_bg)
call s:setbgfg("ConflictMarkerSeparator", s:bg_highlight, s:text_on_bg)

" Swift
call s:setfg("swiftKeywords", s:text_blue)
call s:setfg("swiftAttributes", s:text_blue)
call s:setfg("swiftImports", s:text_blue)
call s:setfg("swiftProperty", s:text_yellow)
call s:setfg("swiftMarker", s:text_yellow)

" Lsp
call s:setfg("DiagnosticError", s:text_red)
call s:setfg("DiagnosticWarn", s:text_yellow)
call s:setfg("DiagnosticHint", s:text_gray)

" Additional VIM things
call s:setbgfg("ColorColumn", s:bg_almost_invisible, s:text_normal) 
call s:setfg("NonText", s:text_invisible_chars)
call s:setbgfg("CursorLine", s:bg_select, s:text_normal) 

" Bufferline colors
execute 'highlight BufferLineActive                    guibg='   . s:bg_select . ' guifg=' . s:text_normal
execute 'highlight BufferLineActiveModified   gui=bold guibg='   . s:bg_select . ' guifg=' . s:text_normal

execute 'highlight BufferLine                  guibg='   . s:bg_almost_invisible . ' guifg=' . s:text_normal
execute 'highlight BufferLineModified gui=bold guibg='   . s:bg_almost_invisible . ' guifg=' . s:text_normal

" Bufferline custom colors
execute 'highlight BufferLineType1Active                     guibg='   . s:bg_select . '           guifg=' . s:text_blue
execute 'highlight BufferLineType1ActiveModified    gui=bold guibg='   . s:bg_select . '           guifg=' . s:text_blue
execute 'highlight BufferLineType1                           guibg='   . s:bg_almost_invisible . ' guifg=' . s:text_blue
execute 'highlight BufferLineType1Modified gui=bold gui=bold guibg='   . s:bg_almost_invisible . ' guifg=' . s:text_blue

execute 'highlight BufferLineType2Active                     guibg=' . s:bg_select . '           guifg=' . s:text_red
execute 'highlight BufferLineType2ActiveModified    gui=bold guibg=' . s:bg_select . '           guifg=' . s:text_red
execute 'highlight BufferLineType2                           guibg=' . s:bg_almost_invisible . ' guifg=' . s:text_red
execute 'highlight BufferLineType2Modified gui=bold gui=bold guibg=' . s:bg_almost_invisible . ' guifg=' . s:text_red

hi link @lsp.type.macro.cpp Macro

hi link LspDiagnosticsDefaultError DiagnosticError
hi link LspDiagnosticsDefaultWarning DiagnosticWarn
hi link LspDiagnosticsDefaultInformation DiagnosticInfo
hi link LspDiagnosticsDefaultHint DiagnosticHint
hi link LspDiagnosticsUnderlineError DiagnosticUnderlineError
hi link LspDiagnosticsUnderlineWarning DiagnosticUnderlineWarn
hi link LspDiagnosticsUnderlineInformation DiagnosticUnderlineInfo
hi link LspDiagnosticsUnderlineHint DiagnosticUnderlineHint
endfunction
