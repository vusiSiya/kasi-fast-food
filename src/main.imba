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


tag app
	items = []
	cartItems = null
	count = 0

	def mount
		window.screen.orientation.onchange = do imba.commit!
		window.document.body.onclick = do()
			const nav = window.document.querySelector("nav-bar")
			const menuElement = window.document.querySelector("div.grid")
			if menuElement	
				nav.showMenu = false
				imba.commit!
	
	def render
		if !items.length
			this.items = await getAllItems!
		
		this.cartItems = await _catch(getCartItems)
		this.count = cartItems && cartItems.reduce(&, 0) do(sum, item)
			return sum + item.count

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
