vim-solargraph
===============

vim plugin (wrapper) for Solargraph - IDE tools for the Ruby language.


NOTES
-----

Please consider this as a first prototype **pre ALPHA** version, just to prove that it can be done.

I am not familiar with vimscript, so most of vimscript code is trial and error + a lot of googling.
This plugin was written in 10 hours after the initial idea (first commit).


INSTALLATION
------------

I've tested this only on Linux. If you think you can make it work on Windows or Mac please submit a patch.


### Prerequisites (my setup)


* Install Ruby (2.4.1)
* Compile vim with `+ruby` support
* `gem install json rest-client solargraph`
* Install [dbakker/vim-projectroot](https://github.com/dbakker/vim-projectroot)


#### vim-plug

Add the following

`Plug 'hackhowtofaq/vim-solargraph'`


### Manual (Not ready yet)

Download `vim-solargraph.tar.gz` from GitHub, extract it, and copy the contents to your `~/.vim` directory.


### neocomplete

If you are using [neocomplete](https://github.com/Shougo/neocomplete.vim) keep reading.

The following is my neocomplete setup. I am still experimenting, trying to find the optimal settings for ruby code.

```vim
		" neocomplete {

		" Neosnipet
		" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
		" SuperTab like snippets' behavior.
		imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
					\ "\<Plug>(neosnippet_expand_or_jump)"
					\: pumvisible() ? "\<C-n>" : "\<TAB>"
		smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
					\ "\<Plug>(neosnippet_expand_or_jump)"
					\: "\<TAB>"

		let g:acp_enableAtStartup = 0
		let g:neocomplete#enable_at_startup = 1
		let g:neocomplete#auto_completion_start_length = 1
		let g:neocomplete#enable_refresh_always = 1
		let g:neocomplete#enable_fuzzy_completion = 0
		let g:neocomplete#enable_smart_case = 1
		let g:neocomplete#enable_auto_delimiter = 1
		let g:neocomplete#enable_auto_select = 1
		let g:neocomplete#enable_underbar_completion = 1
		let g:neocomplete#enable_camel_case_completion  =  1

		if !exists('g:neocomplete#force_omni_input_patterns')
			let g:neocomplete#force_omni_input_patterns = {}
		endif
		let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

		" Define keyword.
		if !exists('g:neocomplete#keyword_patterns')
			let g:neocomplete#keyword_patterns = {}
		endif
		let g:neocomplete#keyword_patterns['default'] = '\h\w*'

		" Enable heavy omni completion.
		if !exists('g:neocomplete#sources#omni#input_patterns')
			let g:neocomplete#sources#omni#input_patterns = {}
		endif

		if !exists('g:neocomplete#same_filetypes')
			let g:neocomplete#same_filetypes = {}
		endif
		let g:neocomplete#same_filetypes.ruby = 'eruby'

		let g:neocomplete#data_directory = $HOME . '/.vim/cache/neocomplete'

		" Enable omni-completion.
		autocmd Filetype ruby,eruby setlocal omnifunc=solargraph#CompleteSolar

		" } neocomplete
```


WORKSPACE (solargraph)
---------

A folder having one of the following entries in it, is assumed to be the workspace folder.

```
['.projectroot', '.git', '.hg', '.svn', '.bzr', '_darcs', 'build.xml']
```



USAGE
-----

* Download something big :P [discourse](https://github.com/discourse/discourse/archive/v1.8.5.tar.gz)?

OR

* Create file `a.rb` and paste

```ruby
# a.rb
class A
  def testInstanceA
  end

  def self.testClassA
  end
end
```

* Create file `a.rb` and paste

```ruby
# b.rb
class B
  def testInstanceB
  end

  def self.testClassB
  end
end
```

* Start solargraph server `$ solargraph server`


* Create file `test.rb`

```ruby
# test.rb

ca = A.new
A.te   # <---- You should see testClassA
ca.te  # <---- You should see testInstanceA


cb = B.new
B.te  # <---- You should see testClassB
cb.te # <---- You should see testInstanceB

```


Without `neocomplete` use `CTRL+x CTRL+o` shortcut to autocomplete after the dot `.`



AUTHOR
------

George Lazaridis <glaz330-vim@yahoo.com>
