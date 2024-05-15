import {getTotalPrice, getCartItems, removeItem, updateItemCount} from "../../api.js"


css .total-price 
		bgc: #fffff1 @hover:black c: black @hover: white
		p:.5em fw: bold rd:.28rem 


tag cart-items

	def handleClick e
		const {id} = e.target
		const item = cartItems.find do(item) item.id === id
		await removeItem(id)
		item.count = 0 

	def handleChange e
		const {id,value} = e.target
		const item = cartItems.find do(item) item.id === id
		let new-count = Number(value)	
		await updateItemCount(item.id, new-count)
		item.count = new-count


	def render
		cartItems = await getCartItems!
		total-price = await getTotalPrice!

		<self[d:grid g:.5em]>
			<div [d:flex ai:center]>	
				<h1 [m:.8em 3.2rem c:white]> "On your cart" 
				<p.total-price> 
					<i.fa-solid .fa-coins .fa-beat-fade> 
					" R{total-price}"
					
			<div.container [d:vflex]>
				if !cartItems
					<loading-spinner>
				else

					for item in cartItems
						unless !item.count
							<div.menu-item [td:none ai:flex-end g:1em w:auto mx: 3.2em @!760: auto mt: .5em]>
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
										<i.remove-item .fa-solid .fa-trash-can 
											id=item.id
											title="delete"
											@click.flag('busy').wait(500ms)=handleClick>
											