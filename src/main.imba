
import "./components/layout.imba"
import {getAllItems, get} from "../api.js"


global css 
	html,body m:0
	body bgc: #527e7a fs:1rem ff:Arial d:grid g:.25em w:100% 

	a c:inherit td:none

	.container d:flex jc:center g:1rem w:100%
	.count bgc: #c51950 rd:100%  c: white p: .25em .5em fw:bold

	.menu-item d:flex g:1rem p:.5em bgc: #ffffe0c2 c:black w:15rem max-width:45rem
		rd: .5rem box-shadow: none @hover: 0 0 18px 8px #344544 

	.menu-item@!760 d:grid ai:flex-end m:0 auto max-width: max-content 
	
	.item-image w:100% max-width:16rem @!760:19rem aspect-ratio:1  rd:.27rem ff:italic

	.item-content d:grid g:1rem
	.item-name, .item-price m: .75rem 0 .125rem
	
	.item-count-input 	
		bd:4px solid #537f7b @hover:4px #689F38 rd: .25rem
		ta: center fs: medium  w:11rem py:.25em px:.5em m:0

	.cart-btn 
		bd: 1px solid black rd: .25rem fs: larger fw: bold 
		p: .325rem .9em c:inherit bgc:white
		@hover c:white bgc:black
	
	.busycart c:white bgc:black pointer-events:none;
	
	.busy pointer-events:none opacity:50%
	.remove-item fs:large mx: .8em 


tag app
	<self>
		<layout>
			<menu-items 
				items=(await get(getAllItems))
				route="/items" 
			>
			<sign-in-prompt route="/not-signed-in">
			<cart-items route="/items-on-cart">
			<item-detail route="/item-detail/:id">
			<login route="/login">

			
imba.router.alias("/", "/items")
imba.mount do <app>
