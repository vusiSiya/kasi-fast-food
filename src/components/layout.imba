
import {
	authSignOut,
	getTotalCount,
	checkAuthState
} from "../../api.js"

import "./loading-spinner.imba"
import "../pages/login.imba"
import "../pages/cart-items.imba"                                                                                      
import "../pages/item-detail.imba"
import "../pages/menu-items.imba"


css 
	section d:flex g:1.5em ai:flex-end m:.5em

	.count bgc: #c51950 p: .20rem .5rem rd: 100% c: white fs:small

	a p:.4em rd:.28em bgc:white c:black td:none ta:center
		@hover bgc: black3 c:white
	

tag layout

	def render
		let totalCartItems = await getTotalCount!
		let signedIn = checkAuthState!
		# shouldBeat = totalCartItems && (document.location.pathname === '/items-on-cart')

		<self [d:grid]>
			<nav [d:flex jc:space-between bgc:#75a1a1 c:white pos:fixed top:0 p:.5em  w:100%  mb:.8em ]>
				<section>
					<h2 [m:0 ml:2rem @!760:auto]> "Fast Food"
					<div [d:flex g:1em]>
						<a [d:flex fw:bold ai:center g:.25rem] route-to=(signedIn ? "items-on-cart" : "/not-signed-in")> 
							<i.fa-solid .fa-truck-fast>
							<span.count> totalCartItems
						<a [fw:bold] route-to=(signedIn ? "items" : "/not-signed-in" )> "Menu"

				<section [jc:end pr:5rem] >
					<a route-to="login"> "Login"	
					<a route-to="login" @click=(do await authSignOut!)> "Logout"				
			<main[d:vflex mt:7.5rem mb:2.5rem]>
				<slot>

			### <footer [m:1em auto c:white]> 
				<section> "© {new Date!.getFullYear!} Siyabonga Mahlalela"
				



			
			
			

