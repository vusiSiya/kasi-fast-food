import {
	removeItem,
	addItemToCart,
	updateItemCount,
	getSingleCartItem,
	getSingleItem,
	checkAuthState,
	attempt
} from "../../api.js"


css .update-count bgc:white px:.75rem py:.25rem fs:small bd:1px solid black rd:.25rem c:black

css a.login td:underline c:-webkit-link


tag item-detail
	prop item = {}

	def handleChange e 
		item.count = Number(e.target.value)
		await updateItemCount(item.id, item.count)

	def handleClick e
		const {id} = e.target 
		if checkAuthState!
			if id === "remove"
				await removeItem(item.id)
				item.count = 0	
			else if id === "add"
				item.count = 1
				await addItemToCart(item.id, item.count)	
			else
				const new-count = (id === "update-plus") ? item.count + 1 : item.count - 1
				item.count = new-count
				return (new-count < 1) ? await removeItem(item.id) : await updateItemCount(item.id, new-count)

	def routed(params)
		item = await attempt(getSingleCartItem(params.id)) || await attempt(getSingleItem(params.id))
	
	<self.container [d:vflex g:0]>
		<a route-to="/items" [m:1rem 2rem @!760:1rem c:white] > "← back to menu"

		if !item
			<loading-spinner>
		else
			<div.menu-item [m:.5em 3.2em @!760:auto ai:flex-end g:1em w:auto min-width:max-content]>
				<img.item-image src=item.imgUrl alt=item.name >
				<div.item-content>
					<h2.item-name> item.name
					<p.item-price> "R {item.price}"
					
					<div [d:flex flex-wrap:wrap ai:center g: .75em]>
						if !item.count
							<button.cart-btn 
								id="add" 
								@mousedown.flag('busycart').wait(500ms)=handleClick
							>  "Add To Cart"

							(checkAuthState! === false) && <p [fs:small fw:bold]>
									"You need to {<a.login route-to="/login"> "login"} first"

						else
							
							if (item.count < 4) 
								<button.update-count
									id="update-plus"
									@mousedown.flag('busy').wait(500ms)=handleClick
								> "+"
								<span.count .fa-beat> item.count
								<button.update-count
									id="update-minus"
									@mousedown.flag('busy').wait(500ms)=handleClick
								> "-"							
							else
								<input.item-count-input
									type="number"
									value=item.count 
									@change=handleChange
								/>

							<i.remove-item .fa-solid .fa-trash-can
								id="remove"
								title="Delete"
								@mousedown.flag('busy').wait(500ms)=handleClick>
							

