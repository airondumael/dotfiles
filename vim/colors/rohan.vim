" colorcolorscheme {{{
  set t_Co=256
  let g:colors_name = "rohan"
  let bgcolor = "dark"
  highlight clear SignColumn
  syntax reset
"}}}

" Functions {{{
" ---------------------------------------------------------------------
" Returns an approximate grey index for the given grey level
fun <SID>grey_number(x)
    if &t_Co == 88
        if a:x < 23
            return 0
        elseif a:x < 69
            return 1
        elseif a:x < 103
            return 2
        elseif a:x < 127
            return 3
        elseif a:x < 150
            return 4
        elseif a:x < 173
            return 5
        elseif a:x < 196
            return 6
        elseif a:x < 219
            return 7
        elseif a:x < 243
            return 8
        else
            return 9
        endif
    else
        if a:x < 14
            return 0
        else
            let l:n = (a:x - 8) / 10
            let l:m = (a:x - 8) % 10
            if l:m < 5
                return l:n
            else
                return l:n + 1
            endif
        endif
    endif
endfun

" Returns the actual grey level represented by the grey index
fun <SID>grey_level(n)
    if &t_Co == 88
        if a:n == 0
            return 0
        elseif a:n == 1
            return 46
        elseif a:n == 2
            return 92
        elseif a:n == 3
            return 115
        elseif a:n == 4
            return 139
        elseif a:n == 5
            return 162
        elseif a:n == 6
            return 185
        elseif a:n == 7
            return 208
        elseif a:n == 8
            return 231
        else
            return 255
        endif
    else
        if a:n == 0
            return 0
        else
            return 8 + (a:n * 10)
        endif
    endif
endfun

" Returns the palette index for the given grey index
fun <SID>grey_colour(n)
    if &t_Co == 88
        if a:n == 0
            return 16
        elseif a:n == 9
            return 79
        else
            return 79 + a:n
        endif
    else
        if a:n == 0
            return 16
        elseif a:n == 25
            return 231
        else
            return 231 + a:n
        endif
    endif
endfun

" Returns an approximate colour index for the given colour level
fun <SID>rgb_number(x)
    if &t_Co == 88
        if a:x < 69
            return 0
        elseif a:x < 172
            return 1
        elseif a:x < 230
            return 2
        else
            return 3
        endif
    else
        if a:x < 75
            return 0
        else
            let l:n = (a:x - 55) / 40
            let l:m = (a:x - 55) % 40
            if l:m < 20
                return l:n
            else
                return l:n + 1
            endif
        endif
    endif
endfun

" Returns the actual colour level for the given colour index
fun <SID>rgb_level(n)
    if &t_Co == 88
        if a:n == 0
            return 0
        elseif a:n == 1
            return 139
        elseif a:n == 2
            return 205
        else
            return 255
        endif
    else
        if a:n == 0
            return 0
        else
            return 55 + (a:n * 40)
        endif
    endif
endfun

" Returns the palette index for the given R/G/B colour indices
fun <SID>rgb_colour(x, y, z)
    if &t_Co == 88
        return 16 + (a:x * 16) + (a:y * 4) + a:z
    else
        return 16 + (a:x * 36) + (a:y * 6) + a:z
    endif
endfun

" Returns the palette index to approximate the given R/G/B colour levels
fun <SID>colour(r, g, b)
    " Get the closest grey
    let l:gx = <SID>grey_number(a:r)
    let l:gy = <SID>grey_number(a:g)
    let l:gz = <SID>grey_number(a:b)

    " Get the closest colour
    let l:x = <SID>rgb_number(a:r)
    let l:y = <SID>rgb_number(a:g)
    let l:z = <SID>rgb_number(a:b)

    if l:gx == l:gy && l:gy == l:gz
        " There are two possibilities
        let l:dgr = <SID>grey_level(l:gx) - a:r
        let l:dgg = <SID>grey_level(l:gy) - a:g
        let l:dgb = <SID>grey_level(l:gz) - a:b
        let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
        let l:dr = <SID>rgb_level(l:gx) - a:r
        let l:dg = <SID>rgb_level(l:gy) - a:g
        let l:db = <SID>rgb_level(l:gz) - a:b
        let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
        if l:dgrey < l:drgb
            " Use the grey
            return <SID>grey_colour(l:gx)
        else
            " Use the colour
            return <SID>rgb_colour(l:x, l:y, l:z)
        endif
    else
        " Only one possibility
        return <SID>rgb_colour(l:x, l:y, l:z)
    endif
endfun

" Returns the palette index to approximate the 'rrggbb' hex string
fun <SID>rgb(rgb)
    let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
    let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
    let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

    return <SID>colour(l:r, l:g, l:b)
endfun

" Sets the highlighting for the given group
fun <SID>X(group, fg, bg, attr)
    if a:fg != ""
        exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
    endif
    if a:bg != ""
        exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
    endif
    if a:attr != ""
        exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
    endif
endfun
"}}}
" Color Definition
let s:foreground = "e3e2e0"
let s:background = "222222"
let s:light_red = "FF4E50"
let s:red = "cc4455"
let s:strong_red = "ff0000"
let s:blue = "557799"
let s:cyan = "3bc7b8"
let s:light_blue = "bbddff"
let s:moderate_blue = "446688"
let s:strong_blue = "0066cc"
let s:desaturated_blue = "334455"
let s:light_orange = "EDB92E"
let s:orange = "ffeecc"
let s:light_gray = "e3e2e0"
let s:light_magenta = "ffccff"
let s:gray = "aaaaaa"
let s:green = "337700"

" user interface
call <SID>X("Cursor", s:red, s:foreground, "")
call <SID>X("CursorIM", s:red, s:foreground, "")
call <SID>X("Normal", s:foreground, s:background, "")
call <SID>X("NonText", s:foreground, s:background, "")
call <SID>X("Visual", s:foreground, s:blue, "")

call <SID>X("Folded", s:foreground, "", "")

call <SID>X("Linenr", s:gray, "", "")

call <SID>X("Directory", s:green, "", "")

call <SID>X("IncSearch", s:foreground, s:strong_blue, "")
call <SID>X("Search", s:foreground, s:strong_blue, "")

call <SID>X("SpecialKey", s:foreground, "", "")
call <SID>X("Titled", s:foreground, "", "")

call <SID>X("ErrorMsg", s:strong_red, "", "")
call <SID>X("ModeMsg", s:orange, "", "")
call <SID>X("MoreMsg", s:orange, "", "")
call <SID>X("Question", s:light_red, "", "")
call <SID>X("WarningMsg", s:light_red, "", "")

call <SID>X("StatusLine", s:background, s:orange, "")
call <SID>X("StatusLineNC", s:foreground, s:red, "")
call <SID>X("VertSplit", s:foreground, s:red, "")

call <SID>X("DiffAdd", s:blue, "", "")
call <SID>X("DiffChange", s:green, "", "")
call <SID>X("DiffDelete", s:red, "", "")
call <SID>X("DiffText", s:foreground, "", "")

" color syntax
call <SID>X("Comment", s:gray, "", "")

call <SID>X("Constant", s:foreground, "", "")
call <SID>X("String", s:cyan, "", "")
call <SID>X("Character", s:cyan, "", "")
call <SID>X("Number", s:red, "", "")
call <SID>X("Boolean", s:red, "", "")
call <SID>X("Float", s:red, "", "")

call <SID>X("Identifier", s:light_gray, "", "")
call <SID>X("Function", s:cyan, "", "")
call <SID>X("Statement", s:cyan, "", "")

call <SID>X("Conditional", s:light_orange, "", "")
call <SID>X("Repeat", s:light_orange, "", "")
call <SID>X("Label", s:light_magenta, "", "")
call <SID>X("Operator", s:light_orange, "", "")
call <SID>X("Keyword", s:light_orange, "", "")
call <SID>X("Exception", s:cyan, "", "")

call <SID>X("PreProc", s:light_orange, "", "")
call <SID>X("Include", s:light_red, "", "")
call <SID>X("Define", s:light_red, "", "")
call <SID>X("Macro", s:light_red, "", "")
call <SID>X("PreCondit", s:light_red, "", "")

call <SID>X("Type", s:light_red, "", "")
call <SID>X("StorageClass", s:cyan, "", "")
call <SID>X("Structure", s:light_gray, "", "")
call <SID>X("Typedef", s:light_red, "", "")

call <SID>X("Special", s:light_blue, "", "")
call <SID>X("SpecialChar", s:light_blue, "", "")
call <SID>X("Tag", s:light_blue, "", "")
call <SID>X("Delimiter", s:orange, "", "")
call <SID>X("SpecialComment", s:desaturated_blue, s:gray, "")
call <SID>X("Debug", s:light_red, "", "")

call <SID>X("Underlined", "", "", "underline")

call <SID>X("Title", s:light_gray, "", "")
call <SID>X("Ignore", s:gray, "", "")
call <SID>X("Error", s:strong_red, "", "")
call <SID>X("Todo", s:desaturated_blue, s:gray, "")

call <SID>X("htmlH2", s:foreground, "", "")
call <SID>X("htmlH3", s:foreground, "", "")
call <SID>X("htmlH4", s:foreground, "", "")
call <SID>X("htmlH5", s:foreground, "", "")
call <SID>X("htmlH6", s:foreground, "", "")

call <SID>X("javaScriptBraces", s:light_red, "", "")
call <SID>X("javaScriptParens", s:light_orange, "", "")
call <SID>X("javaScriptIdentifier", s:red, "", "")
call <SID>X("javaScriptFunction", s:cyan, "", "")
call <SID>X("javaScriptConditional", s:strong_red, "", "")
call <SID>X("javaScriptRepeat", s:light_magenta, "", "")
call <SID>X("javaScriptNumber", s:green, "", "")
call <SID>X("javaScriptMember", s:orange, "", "")
call <SID>X("javascriptNull", s:red, "", "")
call <SID>X("javascriptGlobal", s:blue, "", "")
call <SID>X("javascriptStatement", s:strong_red, "", "")


"vim-javascript
call <SID>X("jsBrackets", s:light_red, "", "")
call <SID>X("jsParens", s:light_orange, "", "")
call <SID>X("jsBraces", s:light_red, "", "")
call <SID>X("jsFuncBraces", s:red, "", "")

" Delete Functions {{{
delf <SID>X
delf <SID>rgb
delf <SID>colour
delf <SID>rgb_colour
delf <SID>rgb_level
delf <SID>rgb_number
delf <SID>grey_colour
delf <SID>grey_level
delf <SID>grey_number
"}}}

