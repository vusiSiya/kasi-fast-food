import {
	removeItem,
	addItemToCart,
	updateItemCount,
} from "../../api"
import {checkAuthState} from "../../auth"

css .update-count bgc:white px:.75rem py:.25rem
	fs:small bd:1px solid black rd:.25rem c:black
css a.login td:underline c:-webkit-link
css .prompt fs:small fw:bold d:block


tag item-detail
	prop allItems = null
	prop cartItems = null
	item = null
	errorMsg = ""
	
	def handleChange e 
		try
			let newCount = Number(e.target.value)
			if (newCount < 0 || newCount > 15)
				item.count = newCount < 1 ? 1 : 15
				await updateItemCount(item.id, item.count)
				throw new Error("Enter a value from 1 - 15")
			else if (newCount > 0 && newCount <= 15)
				await updateItemCount(item.id, newCount)
			else if (newCount === 0)
				await removeItem(item.id)
			item.count = newCount
			imba.commit!
		catch err
			errorMsg = err.message

	def handleClick e
		const {id} = e.target 
		const isLoggedIn = checkAuthState!
		let isWithinRange = false

		try
			if isLoggedIn
				if id === "remove"
					await removeItem(item.id)	
					item.count = 0
				else if id === "add"
					await addItemToCart(item.id)
					item.count = 1
				else if (id === "update-plus")
					const count = (item.count < 4) ? item.count + 1 : 1
					await updateItemCount(item.id, count)
					item.count = count;
				else if (id === "update-minus")
					const count = (item.count) < 4 ? item.count - 1 : 1
					await updateItemCount(item.id, count)
					item.count = count
				if (item.count == 0)
					await removeItem(item.id)
					item.count = 0
		catch err
			errorMsg = err.message

	def render
		const id = this.route.params.id
		const cartItem =  cartItems && cartItems.find do(item) item.id === id
		const generalItem = this.allItems && this.allItems.find do(item) item.id === id
		item = cartItem || generalItem 

		const limitError = "Enter a value from 1 - 15"

		<self.container [d:vflex g:0]>
			<a route-to="/items" [m:1rem 2rem @!760:1rem c:white] > "← back to menu"
			
			if !item
				<loading-spinner>
			else
				<div.menu-item [m:.5em 3.2em @!760:auto ai:flex-end g:1em w:auto min-width:max-content]>
					<img.item-image width="240" src=item.imgUrl alt=item.name >
					<div.item-content>
						<h2.item-name> item.name
						<p.item-price> "R {item.price}"

						<error-message 
							bind:msg=errorMsg 
							specialMsg=limitError
						/>

						<div [d:flex flex-wrap:wrap ai:center g: .75em]>
							if !item.count
								<button.cart-btn 
									id="add"
									@mousedown.flag('busy-cart', 'button')=handleClick
								> "Add To Cart"
								!checkAuthState() && <p .prompt> "You need to {<a.login route-to="/login"> "login"} first"

							else
								if (item.count < 4 && item.count > 0) 
									<button.update-count
										id="update-plus"
										@mousedown.flag('busy', 'div').wait(300ms)=handleClick
									> "+"
									<span.count .fa-beat> item.count
									<button.update-count
										id="update-minus"
										@mousedown.flag('busy', 'div').wait(300ms)=handleClick
									> "-"							
								else
									<input.item-count-input 
										type="number" 
										min="0"
										max="15"
										value=item.count
										@change.flag('busy', 'input').wait(200ms)=handleChange 
									/>
									
								<i.remove-item .fa-solid .fa-trash-can
									id="remove"
									title="Delete"
									@mousedown.flag('busy', 'div').wait(200ms)=handleClick
								>

							
