
import { authSignOut } from "../../auth"
import "./sign-in-prompt.imba"
import "./loading-spinner.imba"
import "./nav-bar.imba"
import "../pages/login.imba"
import "../pages/cart-items.imba"                                                                                      
import "../pages/item-detail.imba"
import "../pages/menu-items.imba"


css nav-bar d:flex jc:space-between bgc:#75a1a1 c:white 
	pos:fixed top:0 p:.5em w:100%  mb:.8em z-index:2
	
css main d:vflex mt:7.5rem mb:2.5rem
css footer pos:fixed b:0 left:0 right:0 ta:center c:white z-index: -1
css footer > p > a ml:.5em p:0 bgc:transparent c:white
css .fa-github rd:full td@hover:underline

tag layout
	def render
		<self [d:grid]>
			<nav-bar>
			<main>
				<slot>
			<footer> 
				<p [m:0 mb:.5em]> "© {new Date!.getFullYear!} Siyabonga Mahlalela"
					<a href="https://github.com/vusiSiya/kasi-fast-food" target="_blank" rel="noreferrer">
						<i .fa-brands .fa-github>
		
