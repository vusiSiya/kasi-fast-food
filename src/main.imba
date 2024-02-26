
import "./components/layout.imba"
import {getAllItems} from "../api.js"

global css 
	html,body m:0
	body bgc: #527e7a fs:1rem ff:Arial d:grid g:.25em w:100% 

	a c:inherit td:none

	.container d:flex jc:center g:1rem w:100%
	.count bgc: #c51950 rd: 100%  c: white p: .25em .5em fw:bold

	.menu-item d:flex g:1rem p:.5em bgc: #ffffe0c2 c:black max-width:53rem
		rd: .5rem box-shadow: none @hover: 0 0 18px 8px #344544 

	.menu-item@!760 d:grid ai:flex-end m:0 auto max-width: max-content 
	
	.item-image w:100% max-width:19rem aspect-ratio:1  rd:.27rem 

	.item-content d:grid g:1rem
	.item-name, .item-price m: .75rem 0 .125rem
	
	.item-count-input 	
		bd:4px solid #537f7b @hover:4px #689F38 rd: .25rem
		ta: center fs: medium  w: auto p: .25em .5em m:0

tag app

	prop items = getAllItems!
	prop pathname = document.location.pathname
	prop paramsId = Number(pathname[pathname.length - 1]) || Number(Math.floor(Math.random! * items.length) + 1)

	def getBoughtItems
		const newArray = items.filter do(item) item.count
		return newArray
	
	<self>
		<layout pathname=pathname paramsId=paramsId>
			<item-detail route="/items/:id" itemId=paramsId>
			<login route="/login"> 
			<menu-items route="/items">
			<bought-items route="/bought-items" boughtItems=getBoughtItems()>


imba.router.alias("/", "/items");
imba.mount do <app>
