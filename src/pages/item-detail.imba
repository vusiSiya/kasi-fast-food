import {
	removeItem,
	addItemToCart,
	updateItemCount,
	getSingleCartItem,
	getSingleItem,
	_catch
} from "../../api"
import {checkAuthState} from "../../auth"

css .update-count bgc:white px:.75rem py:.25rem
	fs:small bd:1px solid black rd:.25rem c:black
css a.login td:underline c:-webkit-link


tag item-detail
	prop item = {}
	prop errorMsg

	def handleChange e 
		item.count = Number(e.target.value)
		await updateItemCount(item.id, item.count)
		imba.commit!

	def handleClick e
		const {id} = e.target 
		if checkAuthState!
			try
				if id === "remove"
					item.count = 0
					await removeItem(item.id)	
				else if id === "add"
					item.count = 1
					await addItemToCart(item.id)
				else
					const new-count = (id === "update-plus") ? item.count + 1 : item.count - 1;
					(new-count < 1 ) ? await removeItem(item.id) : await updateItemCount(item.id, new-count)
					item.count = new-count
			catch err
				errorMsg = err
	
	def routed(params)
		const cartItem = await getSingleCartItem(params.id)
		this.item = cartItem || await getSingleItem(params.id)

	def render
		<self.container [d:vflex g:0]>
			<a route-to="/items" [m:1rem 2rem @!760:1rem c:white] > "← back to menu"

			<div.menu-item [m:.5em 3.2em @!760:auto ai:flex-end g:1em w:auto min-width:max-content]>
				<img.item-image width="240" src=item.imgUrl alt=item.name >
				<div.item-content>
					<h2.item-name> item.name
					<p.item-price> "R {item.price}"
					<div [d:flex flex-wrap:wrap ai:center g: .75em]>
						if !item.count
							<button.cart-btn 
								id="add" 
								@mousedown.flag('busycart', 'button').wait(500ms)=handleClick
							> "Add To Cart"
							
							!checkAuthState() && <p [fs:small fw:bold d:block]>
								"You need to {<a.login route-to="/login"> "login"} first"
						else
							
							if (item.count < 4) 
								<button.update-count
									id="update-plus"
									@mousedown.flag('busy', 'div').wait(500ms)=handleClick
								> "+"
								<span.count .fa-beat> item.count
								<button.update-count
									id="update-minus"
									@mousedown.flag('busy', 'div').wait(500ms)=handleClick
								> "-"							
							else
								<input.item-count-input type="number" value=item.count @change=handleChange />
								
							<i.remove-item .fa-solid .fa-trash-can
								id="remove"
								title="Delete"
								@mousedown.flag('busy', 'div').wait(500ms)=handleClick
							>
						if errorMsg
							<p [c:red m:0]> "An Error Occured"
							<span[d:none]> setTimeout(&, 500) do errorMsg = null 

