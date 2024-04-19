import {removeItem, addItemToCart, updateItemCount} from "../../api.js"

css .cart-btn 
		bd: 2px solid black rd: .25rem fs: larger fw: bold 
		p: .325rem .9em c:inherit @hover:white bgc:white @hover:black

	.update-count bgc:white b:1px solid black


tag item-detail
	prop item
	prop count = 0

	def handleChange e
		count = Number(e.target.value)

	def handleClick e
		const {id} = e.target 
		if id === "remove"
			removeItem(item.id)

		else if id === "add"
			count = 1 
			addItemToCart({...item}, count)
			imba.commit!
		else
			let newCount = (id === "update_plus") ? count++ : count-- 
			updateItemCount(item.id, newCount)
			imba.commit!
		

	<self.container [d:vflex g:0] >
		<a route-to="/items" [m:1rem 2rem @!760:1rem c:white] > "← back to menu"

		if !item
			<section [m:5em auto c:white]> 
				<p> "loading " 
					<i .fa-solid .fa-spinner .fa-spin-pulse>
		else
			<div.menu-item [m:.5em 3.2em @!760:auto ai:flex-end w:auto g:1em min-width:max-content]>
				<img.item-image src=item.imgUrl alt=item.name />
				<div.item-content>
					<h2.item-name> item.name
					<p.item-price> "R {item.price}"
					
					<div [d:flex ai:center g: .75em]>
						if item.count > 3
							<input.item-count-input
								type="number"
								value=count 
								@change=handleChange(e)
							/>
							<button id="remove" @click=handleClick route-to="/" /> "Remove"
							
						else 
							count && (
								<button.update-count id="update_plus" @click=handleClick> "+"
							) || <button.cart-btn id="add" @click=handleClick> "Add To Cart"

							<span.count .fa-beat> count
							<button.count .update-count id="update_minus" @click=handleClick> "-"
			
			
