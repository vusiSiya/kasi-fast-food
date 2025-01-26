import "./components/sign-in-prompt.imba"
import "./components/loading-spinner.imba"
# import "./components/small-screen-menu.imba"
# import "./components/big-screen-menu.imba"
import "./components/nav-bar.imba"
import "./components/footer-tag.imba"

import "./pages/login.imba"
import "./pages/cart-items.imba"                                                                                      
import "./pages/item-detail.imba"
import "./pages/menu-items.imba"
import "./components/styles.imba"

import { getAllItems, _catch } from "../api"
import type { Item } from "../types"


tag app
	items = []

	def mount
		items = await _catch<Item[]>(getAllItems)

		# side effects
		window.screen.orientation.onchange = do imba.commit!
		window.document.body.onclick = do()
			const nav = window.document.querySelector("nav-bar")
			const menuElement = window.document.querySelector("div.grid")
			if menuElement
				nav.showMenu = false
				imba.commit!	
				
					
	<self>
		<nav-bar>
		<main>
			<menu-items route="/items" items=items>
			<item-detail route="/item-detail/:id">
			<cart-items route="/items-on-cart">
			<login route="/login">
			<sign-in-prompt route="/not-signed-in">
		<footer-tag>			
				
imba.router.alias("/", "/items")
imba.mount do <app>
