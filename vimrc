" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.
"              Lots of options set via lots of good ideas found on the web
"

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.
"
" Now any plugins you wish to install can be extracted to a subdirectory under
" ~/.vim/bundle

if has ("win32")
    set runtimepath+=$HOME/vimfiles/bundle/
else
    set runtimepath+=$HOME/.vim/bundle/
endif

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

" Allows saving of commands when you forget to use sudo Vim with a W. 
" utilizes tee hack, for more about tee, "man tee"
command! W w !sudo tee % > /dev/null
" allows M$ commands like Copy/paste keyboard shortcuts
behave mswin 

"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden


" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" don't create ~filename backups, very annoying to leave this on and find dozens of extra files scattered about
set nobackup


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a
imap <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
set selectmode-=mouse "Use the mouse just like visual mode, so you can use vim commands on mouse selections, eg. 'x' to cut and 'y' to yank

"This is if you have a dark background in your terminal, light is another option 
set background=dark
"set background=light

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

set nowrap " don't wrap lines longer than the screen's width

set guioptions+=b " show bottom scrollbar when in gvim

set foldmethod=indent " fold code based on indents

set nofoldenable " makes sure the code is not folded when first opened, used 

set scrolloff=4 " Keep 4 lines at minimum above & below the cursor when scrolling around a file

set showmatch " Jumps to the other bracket

"These options are personal preference

set cursorline "Underline the current line the cursor is on.

set incsearch ignorecase hlsearch

" Press space to clear search highlighting and any message already displayed.
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

"Upgrade the status line to give more usefull information
set statusline=%F\ %m%r%w%y\ %=(%L\ loc)\ [#\%03.3b\ 0x\%02.2B]\ \ %l,%v\ \

"Printing (:hardcopy) options
set printoptions=paper:letter,syntax:y,number:y,duplex:off,left:5pc
"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.

set shiftwidth=4

set softtabstop=4

set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
"set shiftwidth=2
"set tabstop=2


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" toggle pasting on and off
set pastetoggle=<F2>


"------------------------------------------------------------
" Colors {{{1



" if terminal supports 256 coloring
if &term =~ "xterm-256color"
    "For bright monitors, 'ir-black' is nice to the eyes, enable 256 mode an
    colorscheme ir_black
endif

" if xterm, assume color is OK; btw =~ means ignore case and also somehow
" xterm-256color was still being caught by it  
if &term == "xterm" || &term == "xterm-color"
    set t_Co=8
    "Tell vim it's ok to send color
    if &term =~ "xterm"
        set term=xterm-color
    endif
    "All around well balanced colorscheme
    "  colorscheme ron
    "For med-dark monitors 'ron' or 'koehler' colorschemes are great
     colorscheme koehler
endif

" for screen sessions
if &term == "screen"
  set t_Co=256
endif

if has('gui_running')
    set t_Co=256
    colorscheme ir_black
endif

"------------------------------------------------------------
" Syntastic configs
"

let g:syntastic_check_on_open=1

let g:syntastic_enable_signs=1

let g:syntastic_auto_jump=1

let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

set statusline+=%#warningmsg#

set statusline+=%{SyntasticStatuslineFlag()}

set statusline+=%*

" and A jsHint config
let g:js_indent_log = 1

"------------------------------------------------------------
"
" Autocompletion
set ofu=syntaxcomplete#Complete

autocmd FileType php set omnifunc=phpcomplete#CompletePHP

autocmd FileType phtml set omnifunc=phpcomplete#CompletePHP

autocmd FileType python set omnifunc=pythoncomplete#Complete

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

autocmd FileType css set omnifunc=csscomplete#CompleteCSS

autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

autocmd FileType c set omnifunc=ccomplete#Complete

"disable preview menu, because scratch view is annoying?
set completeopt =longest,menuone,menu

highlight Pmenu guibg=brown gui=bold

highlight Pmenu ctermbg=238 gui=bold

" remap ctrl-x + ctrl-o to SuperTabfor omnicomplete
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"

" lets SuperTab decide which completion mode to use and should play well with OmniCompletion
let g:SuperTabDefaultCompletionType = "context"

" When enabled, supertab will attempt to close vim's completion preview window
" when the completion popup closes (completion is finished or canceled).
let g:SuperTabClosePreviewOnPopupClose = 1

"----------------------------------------------------------
" Node-complete
"
" add node library to dict
au FileType javascript set dictionary+=$HOME/.vim/dict/node.dict
let g:nodejs_complete_config = {'js_compl_fn': 'jscomplete#CompleteJS', 'max_node_compl_len':15}
"------------------------------------------------------------
" Misc
"

"If your having trouble with the backspace character, try uncommenting these
"imap <C-?> <BS>
"imap <C-H> <BS>
"inoremap <BS>

if has("autocmd")
    " Have Vim jump to the last position when reopening a file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g'\"" | endif
    " Support mips.asm files
    autocmd BufNewFile,BufRead *.mips.asm set syntax=mips.vim
    " Trim Trailing white space on general files
    autocmd FileType c,cpp,java,php,js,css,xml,xsl,s autocmd BufWritePre * :
endif

" Support for Gundo, a visual & mini tree structure of document changes
nnoremap <F5> :GundoToggle<CR>
" Set persistant undo
set undodir=~/.vim/undodir
set undofile

" spelling
if v:version >= 700
  " Enable spell check for text files
  autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en
endif


if exists("+showtabline")
     function MyTabLine()
         let s = ''
         let t = tabpagenr()
         let i = 1
         while i <= tabpagenr('$')
             let buflist = tabpagebuflist(i)
             let winnr = tabpagewinnr(i)
             let s .= '%' . i . 'T'
             let s .= (i == t ? '%1*' : '%2*')
             let s .= ' '
             let s .= i . ')'
             let s .= ' %*'
             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
             let file = bufname(buflist[winnr - 1])
             let file = fnamemodify(file, ':p:t')
             if file == ''
                 let file = '[No Name]'
             endif
             let s .= file
             let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%='
         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
         return s
     endfunction
     set stal=2
     set tabline=%!MyTabLine()
endif