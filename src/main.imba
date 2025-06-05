import "./components/error-message.imba"
import "./components/sign-in-prompt.imba"
import "./components/loading-spinner.imba"
import "./components/nav-bar.imba"
import "./components/footer-tag.imba"
import "./pages/login.imba"
import "./pages/cart-items.imba"                                                                                      
import "./pages/item-detail.imba"
import "./pages/menu-items.imba"
import "./components/styles.imba"
import { getAllItems, getCartItems, _catch} from "../api"
import {auth} from "../auth.ts";

tag app
	items = []
	cartItems = []
	count = 0

	def mount
		this.items = await getAllItems!
		window.screen.orientation.onchange = do imba.commit!
		window.document.body.onclick = do()
			const nav = window.document.querySelector("nav-bar")
			const menuElement = window.document.querySelector("div.grid")
			if menuElement	
				nav.showMenu = false
				imba.commit!
		
		if window.navigator.userAgent.includes("Firefox") then return
		const entries = window.navigation.entries!
		const {entry, from} = window.navigation.activation

		if (entry != null && from != null)
			const isRedirectBackTraversal = entry.index != -1 && (from.index - entry.index) > 1 
			if (isRedirectBackTraversal)
				const current = window.navigation.currentEntry
				window.history.pushState({}, "", from.url)
		return	

	def render
		if auth.currentUser != null
			this.cartItems = await getCartItems!
			this.count = cartItems.reduce(&, 0) do(sum, item) sum + item.count

		<self>
			<nav-bar bind:count=count>
			<main>
				<menu-items route="/items" items=items>
				<item-detail 
					route="/item-detail/:id"
					bind:cartItems=cartItems
					allItems=items
				>
				<cart-items route="/items-on-cart" bind:data=cartItems>
				<login route="/login">
				<sign-in-prompt route="/not-signed-in">
			<footer-tag>			
				
imba.router.alias("/", "/items")
imba.mount do <app>
