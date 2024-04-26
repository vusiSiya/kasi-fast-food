import {removeItem, addItemToCart, updateItemCount} from "../../api.js"

css 
	.cart-btn 
		bd: 2px solid black rd: .25rem fs: larger fw: bold 
		p: .325rem .9em c:inherit bgc:white
		@hover c:white bgc:black

	.update-count bgc:white px:.75rem py:.25rem fs:small bd:1px solid black rd:.25rem c:black

tag item-detail
	prop item

	def handleChange e
		let newCount = Number(e.target.value)
		item.count = newCount
		await updateItemCount(newCount)


	def handleClick e
		const {id} = e.target 
		if id === "remove"
			await removeItem(item.id)
			imba.commit!

		else if id === "add"
			item.count = 1
			await addItemToCart({...item}, item.count)
			imba.commit!
			
		else
			let newCount = (id === "update_plus") ? item.count++ : item.count--
			await updateItemCount(item.id, newCount)
			imba.commit!
		

	<self.container [d:vflex g:0] >
		<a route-to="/items" [m:1rem 2rem @!760:1rem c:white] > "← back to menu"

		if !item
			<loading-spinner>
		else
			<div.menu-item [m:.5em 3.2em @!760:auto ai:flex-end w:auto g:1em min-width:max-content]>
				<img.item-image src=item.imgUrl alt=item.name >
				<div.item-content>
					<h2.item-name> item.name
					<p.item-price> "R {item.price}"
					
					<div [d:flex ai:center g: .75em]>
						if !item.count
							<button.cart-btn id="add" @click=handleClick> "Add To Cart"
						else
							
							if(item.count < 3) 
								<button.update-count id="update_plus" @click=handleClick > "+"
								<span.count .fa-beat> item.count
								<button .update-count id="update_minus" @click=handleClick > "-"
							else
								<input.item-count-input
									type="number"
									value=item.count 
									@change=handleChange
								/>

							<button  id="remove" @click=handleClick route-to="/" > "Remove"
							

							
			
			
