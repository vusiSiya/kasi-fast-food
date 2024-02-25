
import "./components/layout.imba"
import {getAllItems} from "../api.js"

global css 
	# body c:warm2 bg:warm8 ff:Arial p: 1em fs:2rem
	html,body m:0
	body bgc: #527e7a fs:2rem ff:Arial d:grid g:.25em w:100% 

	a c:inherit td:none

	.container d:flex @700:grid jc:center g:1em fs: 1.5rem w:100%
	.count bgc: #c51950 rd: 100%  c: white p: .25em .5em fw:bold

	.menu-item d: grid g:1.25em p: 1em fs: medium bgc: #ffffe0c2 c:black max-width:53rem
		rd: .5rem box-shadow: none @hover: 0 0 18px 8px #344544 

	.menu-item@700! d:flex ai:flex-end max-width:48rem

	.item-image h:21rem w:100% aspect-ratio:1 rd:.27rem max-width:22rem @!700:100% 

	.item-content d:grid g:1.5em
	.item-name, .item-price m: .75em 0 .125em fs:x-large
	
	.item-count-input 	
		bd:4px solid #537f7b @hover:4px #689F38 rd: .25rem
		ta: center fs: medium  w: auto p: .25em .5em m:0

tag app

	prop items = getAllItems!
	prop pathname = document.location.pathname
	prop paramsId = Number(pathname[pathname.length - 1]) || Number(Math.floor(Math.random! * items.length) + 1)

	def getBoughtItems
		items.filter do(item) item.count

	def handleItemClick e
		console.log e.detail
	
	<self>
		<layout pathname=pathname paramsId=paramsId @itemClicked.log("item has been clicked")>
			unless pathname === "/items/{paramsId}"
				<item-detail route="/items/:id" itemId=paramsId>
				
			<login route="/login">
			<menu-items route="/items">
			<bought-items route="/bought-items" boughtItems=getBoughtItems>


imba.router.alias("/", "/items");
imba.mount do <app>
