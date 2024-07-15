
import {
	authSignOut,
	getTotalCount,
	checkAuthState
} from "../../api.js"

import "./sign-in-prompt.imba"
import "./loading-spinner.imba"
import "../pages/login.imba"
import "../pages/cart-items.imba"                                                                                      
import "../pages/item-detail.imba"
import "../pages/menu-items.imba"


css 
	section d:flex g:1rem ai:flex-end m:.5em

	.count bgc: #c51950 p: .20rem .5rem rd: 100% c: white fs:small

	a p:.4em rd:.28em bgc:white c:black td:none ta:center
		@hover bgc: black3 c:white
	

tag layout

	def handleLogout e
		const {textContent} = e.target
		const isLogoutBtn = (textContent === "Logout")
		return isLogoutBtn && (await authSignOut!)

	<self [d:grid]>
		<nav [d:flex jc:space-between bgc:#75a1a1 c:white pos:fixed top:0 p:.5em w:100%  mb:.8em z-index:2]>
			<section>
				<h2 [m:0 ml:2rem @!760:auto]> "Fast Food"
				<div [d:flex g:1em]>
					<a [d:flex fw:bold ai:center g:.5rem]
						route-to=(checkAuthState! ? "items-on-cart" : "/not-signed-in")
					> 
						<i.fa-solid .fa-truck-fast>
						<span.count> (await getTotalCount!)
					<a [fw:bold] route-to="items"> "Menu"

			<section [jc:end pr:1.5rem]>
				<a route-to="login" @click=handleLogout> checkAuthState! ? "Logout" : "Login"			
		<main [d:vflex mt:7.5rem mb:2.5rem]>
			<slot>

		<footer [pos:fixed b:0 left:0 right:0  ta:center c:white z-index: -1]> 
			<p [m:0 mb:.5em]> "© {new Date!.getFullYear!} Siyabonga Mahlalela"
				<a[ml:.5em p:0 bgc:transparent c:white]
					href="https://github.com/vusiSiya/kasi-fast-food"
					target="_blank"
				>
					<i .fa-brands .fa-github [rd:full td@hover:underline]>
		
