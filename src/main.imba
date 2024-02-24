
import "./components/layout.imba"
import {data} from "../data.js"

global css 
	# body c:warm2 bg:warm8 ff:Arial p: 1em fs:2rem
	html,body m:0
	body bgc: #527e7a fs:1.25rem ff:Arial d:grid g:.25em w:100%

	a c:inherit td:none

	.container d:flex jc:center g:1em fs: 1.5rem w:100%
	.count bgc: #c51950 rd: 100%  c: white p: .25em .5em fw:bold

	.menu-item bgc: #ffffe0c2 c:black d: grid g:2em w:22rem max-width: 53em  p: 1em fs: large  
		rd: .5rem box-shadow: none @hover: 0 0 18px 8px #344544 

	.item-image h: 21rem max-width: 50rem aspect-ratio:1 rd:.27rem 
	.item-content d:grid g:1.5em
	
	.item-name, .item-price m: .75em 0 .125em;
	.item-count-input 	
		bd:4px solid #537f7b @hover:4px #689F38 rd: .25rem
		ta: center fs: large  w: auto p: .25em .5em m:0

tag app
	count = 0
	<self>
		<%counter @click=count++>
			css e:250ms us:none py:3 px:5 rd:4 bg:gray9 d:hcc g:1
				bd:1px solid transparent @hover:indigo5
			<img[s:20px] src="https://imba.io/logo.svg">
			"count is {count}"
			# <item-detail itemId=5>

imba.mount do <layout autorerender=yes>
