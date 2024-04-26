
import {
	authSignOut,
	getTotalCount,
} from "../../api.js"

import "./loading-spinner.imba"
import "../pages/login.imba"
import "../pages/cart-items.imba"                                                                                      
import "../pages/item-detail.imba"
import "../pages/menu-items.imba"


css 
	nav d: vflex m: 0 0 .8em c: white p: 0.5em 0 bgc: #75a1a1
		min-width: 100% pos:fixed top:0
		
	nav > ul m: 0 d: flex g: .6em 

	li
		m: 1em .5em fw: bold d: flex place-items: center cursor: pointer
		ai: center g: 0  rd: .28rem 	bgc: #fffff1 c: black 
		@hover bgc: black3 c:white

	li > a p: .25em 

	.count bgc: #c51950 p: .20rem .5rem rd: 100% c: white


tag layout

	def getYear
		const date = new Date!
		date.getFullYear!

	def handleLogout
		authSignOut().finally do emit("signed-out")

	
	<self [d:grid]>
		<nav><ul>
				<li> 
					<a route-to="items-on-cart" [d:flex ai:center g:.25em] > 
						<i.fa-solid .fa-cart-shopping>
						<span.count> (await getTotalCount!)
				<li> <a route-to="items"> "Menu Items"
				<li> <a route-to="login"> "Login"
				<li> <a route-to="login" @click=handleLogout > "Logout"

		<main[d:vflex mt:7.5rem]>
			<slot>
		###<footer [m:1em auto c:white]> 
			<section> "© {getYear!} Siyabonga Mahlalela"
			



			
			
			

