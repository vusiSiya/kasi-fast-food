
tag bought-items
	prop boughtItems
	
	def handleClick(itemId)
		const item = boughtItems.find do(item) item.id === itemId
		item.count = 0;

	def handleChange e
		const item = boughtItems.find do(item) item.id === e.target.id
		item.count = e.target.value
		
	# I need to save to localStorage, the count and id of the item added to the cart.
	# initialise item count to the data in localStorage
	# update the item count in localStorage when the count has been changed!
	# Or Has the problem of synchronised state of item count been solved already?
			
	<self.container [d:vflex g:.5em]>
			<h1 [m:.8em 2rem c:white fs:xxx-large]> "Bought Items"
			for item in boughtItems
				unless item.count === 0

					<div.menu-item [td:none ai:flex-end g:1em m: .5em 3.2em]>
						<img.item-image src=item.imgUrl />

						<div.item-content [ai:end g:1.4em]>
							<h2.item-name> item.name
							<p.item-price> "R {item.price}"

							<div [d:flex ai:center g: .5em]>
								<input.item-count-input
									type="number"
									id=item.id 	
									bind=item.count
									@change=handleChange(e)
								/>
								<button.item-count-icon @click=handleClick(item.id)> "Remove"