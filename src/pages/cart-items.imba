import {getTotalPrice, getCartItems, removeItem, updateItemCount} from "../../api.js"


css .total-price 
		bgc: #fffff1 @hover:black c: black @hover: white
		p:.5em fw: bold rd:.28rem 

tag cart-items
	prop cartItems = getCartItems().then do(data) cartItems = data

	def handleClick e
		const item = cartItems.find do(item) item.id === Number(e.target.id)
		item.count = 0; # this line may just be redundant
		await removeItem(item.id)

	def handleChange e
		const item = cartItems.find do(item) item.id === Number(e.target.id)
		let new-count = Number(e.target.value)	
		await updateItemCount(item.id, new-count)
		item.count = new-count


	<self[d:grid g:.5em]>
		<div [d:flex ai:center]>	
			<h1 [m:.8em 3.2rem c:white]> "On your cart" 
			<p.total-price> 
				<i.fa-solid .fa-coins .fa-beat-fade> 
				" R{await getTotalPrice!}"
				
		<div.container [d:vflex]>
			if !cartItems
				<loading-spinner>
			else

				for item in cartItems
					unless !item.count
						<div.menu-item [td:none ai:flex-end g:1em mx: 3.2em @!760: auto mt: .5em]>
							<img.item-image src=item.imgUrl />

							<div.item-content [ai:end g:1.4em]>
								<h3.item-name> item.name
								<p.item-price> "R {item.price}"

								<div [d:flex ai:center g: .5em]>
									<input.item-count-input
										type="number"
										id=item.id 	
										value=item.count
										@change=handleChange
									/>
									<button.item-count-icon id=item.id @click.wait(1s)=handleClick >
										<i.fa-solid .fa-trash-can>