import {getAllItems} from "../../api.js"
	 
css .cart-btn 
		bd: 2px solid black rd: .25rem fs: larger fw: bold 
		p: .325rem .9em c:inherit @hover:white bgc:white @hover:black 

tag item-detail
	
	prop item

	def handleChange e
		item.count = Number(e.target.value)

	<self.container [d:vflex g:0] >
		unless item != null
			<a route-to="/items" [m:1rem c:white] > "← back to menu"

			<div.menu-item 
				[ai:flex-end g:1em m:.5em 3.2em w:auto min-width:max-content]
				@itemClicked.log("item-detail also detected a click")
			>
				<img.item-image src=item.imgUrl alt="{item.name}"/>
				<div.item-content>
					<h2.item-name> item.name
					<p.item-price> "R {item.priceRange[0]}"
					
					<div [d:flex ai:center g: .75em]>
						if item.count > 3
							<input.item-count-input
								type="number"
								value=item.count 
								@change=handleChange(e)
							/>
							<button> "Remove"
						else 
							<button.cart-btn @click=item.count++> "Add To Cart"
							<span.count .fa-beat> item.count		
