
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
	section d:flex g:1.5em ai:flex-end m:.5em

	.count bgc: #c51950 p: .20rem .5rem rd: 100% c: white fs:small

	a fs:large p:.5rem rd:.28rem 
		@hover td:none bgc: black3 c:white
	

tag layout

	def render
		let totalCartItems = await getTotalCount!

		<self [d:grid]>
			<nav [d:grid gtc:2fr 5fr bgc:#75a1a1 c:white pos:fixed top:0 p:.5em  w:100%  mb:.8em ]>
				<section>
					<h2 [m:0 ml:2rem]> "Fast Food"
					<div>
						<a route-to="login" @click=(do await authSignOut!) > "Logout"
						<a route-to="login"> "Login"

				<section [jc:end pr:5rem] >
					<a [fw:bold] route-to="items"> "Menu"
					<a [fw:bold] route-to="items-on-cart" [d:flex ai:center g:.25em]> 
							<i.fa-solid .fa-cart-shopping>
							<span.count> totalCartItems
					
					
			<main[d:vflex mt:7.5rem mb:2.5rem]>
				<slot>
			###<footer [m:1em auto c:white]> 
				<section> "© {getYear!} Siyabonga Mahlalela"
				



			
			
			

