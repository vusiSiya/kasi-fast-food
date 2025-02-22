global css 
	html,body m:0
	body bgc:#527e7a fs:1rem ff:Arial d:grid g:.25em w:100% 
	app d:grid
	a c:inherit td:none

	nav-bar d:flex jc:space-between bgc:#75a1a1 c:white 
		pos:fixed top:0 p:.5em w:100%  mb:.8em z-index:2

	main d:vflex mt:7.5rem mb:2.5rem

	.container d:flex jc:center g:1rem w:100%
	.count bgc:#c51950 rd:100%  c:white p:.25em .5em fw:bold

	.menu-item d:flex g:1rem p:.5em bgc:#ffffe0c2 c:black w:15rem max-width:45rem
		rd:.5rem box-shadow:none @hover:0 0 18px 8px #344544 
	.menu-item@!760 d:grid ai:flex-end m:0 auto max-width:max-content 
	
	.item-image w:100% min-width:12rem max-width:16rem @!760:19rem aspect-ratio:1
		rd:.27rem ff:italic
	.item-content d:grid g:1rem
	.item-name, .item-price m:.75rem 0 .125rem
	
	.item-count-input 	
		bd:4px solid #537f7b @hover:4px #689F38 rd:.25rem
		ta:center fs: medium  w:11rem py:.25em px:.5em m:0

	.cart-btn bd:1px solid black rd:.25rem fs:larger fw:bold 
		p:.325rem .9em c:inherit @hover:white bgc:white @hover:black
	
	.busy-cart c:white bgc:black pointer-events:none opacity:80%
	.busy pointer-events:none opacity:50%
	.remove-item fs:large mx:.8em 

	footer pos:fixed b:0 l:0 r:0 ta:center c:white z-index: -1
	footer > p > a ml:.5em p:0 bgc:transparent c:white
