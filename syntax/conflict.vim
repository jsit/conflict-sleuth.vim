syn region conflict start="^<<<<<<<.*$" end="^>>>>>>>.*$" keepend contains=conflicthead,conflictCommon,conflictRemote

syn region conflictHead start="^<<<<<<<.*$" end="^|||||||\|=======$"me=e-7 keepend contains=conflictMarker
syn region conflictCommon start="^|||||||.*$" end="^=======$"me=e-7 keepend contains=conflictMarker
syn region conflictRemote start="^=======" end="^>>>>>>>.*$" keepend contains=conflictMarker

syn match conflictMarker "^\(<<<<<<<.*\||||||||.*\|>>>>>>>.*\|=======\)$" contained

hi link conflictHead   Constant
hi link conflictCommon Statement
hi link conflictRemote Identifier
hi link conflictMarker Comment

let b:current_syntax = "conflict"
