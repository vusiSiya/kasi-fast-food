
import "./components/layout.imba"
import {getSingleItem, getSingleCartItem, getCartItems,checkAuthState} from "../api.js"


global css 
	html,body m:0
	body bgc: #527e7a fs:1rem ff:Arial d:grid g:.25em w:100% 

	a c:inherit td:none

	.container d:flex jc:center g:1rem w:100%
	.count bgc: #c51950 rd:100%  c: white p: .25em .5em fw:bold

	.menu-item d:flex g:1rem p:.5em bgc: #ffffe0c2 c:black max-width:45rem
		rd: .5rem box-shadow: none @hover: 0 0 18px 8px #344544 

	.menu-item@!760 d:grid ai:flex-end m:0 auto max-width: max-content 
	
	.item-image w:100% max-width:16rem @!760:19rem aspect-ratio:1  rd:.27rem ff:italic

	.item-content d:grid g:1rem
	.item-name, .item-price m: .75rem 0 .125rem
	
	.item-count-input 	
		bd:4px solid #537f7b @hover:4px #689F38 rd: .25rem
		ta: center fs: medium  w: auto p: .25em .5em m:0

	.cart-btn 
		bd: 1px solid black rd: .25rem fs: larger fw: bold 
		p: .325rem .9em c:inherit bgc:white
		@hover c:white bgc:black
	
	.busycart c:white bgc:black pointer-events:none;
	
	.busy pointer-events:none opacity:40%
	.remove-item fs:large mx: .8em 



tag app

	prop item-detail
	prop signedIn = checkAuthState!

	def handleItemClick e
		const {id} = e.detail
		const cartItem = await getSingleCartItem(id)
		const generalItem = await getSingleItem(id)
		item-detail = cartItem or generalItem


	<self>
		<layout @itemClick=handleItemClick>
			<login route="/login">
			if checkAuthState!
				<menu-items route="/items">
				<cart-items route="/items-on-cart" cartItems=(await getCartItems!)>
				<item-detail route="/item-detail/:id" item=item-detail>
			### else
				<section [m:5em auto p:2rem c:white]>
					<h2 [m:auto]> "You are not signed in."
			###
			
			
imba.router.alias("/", "/login")
imba.mount do <app>
