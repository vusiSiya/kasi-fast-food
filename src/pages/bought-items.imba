import {
	getTotalPrice,
} from "../../api.js"

tag bought-items
	
	def handleClick(itemId)
		const item = boughtItems.find do(item) item.id === itemId
		item.count = 0;

	def handleChange e
		const item = boughtItems.find do(item) item.id === e.target.id
		item.count = e.target.value	

	
	css .total-price p:.5em fw: bold rd:.28rem bgc: #fffff1 @hover:black c: black @hover: white

	### div.container@!760 
			grid-template-columns: auto auto
			grid-template-rows: repeat(auto-fit,minmax(23rem,1fr));
	###

	<self[d:grid g:.5em]>

		<div [d:flex ai:center]>	
			<h1 [m:.8em 2rem c:white]> "Bought Items" 
			<p.total-price> "Total: R{getTotalPrice!}"

		<div.container [d:vflex]>
			for item in boughtItems
				<div.menu-item [td:none ai:flex-end g:1em m: .5em 3.2em]>
					<img.item-image src=item.imgUrl />

					<div.item-content [ai:end g:1.4em]>
						<h3.item-name> item.name
						<p.item-price> "R {item.price}"

						<div [d:flex ai:center g: .5em]>
							<input.item-count-input
								type="number"
								id=item.id 	
								bind=item.count
								@change=handleChange(e)
							/>
							<button.item-count-icon @click=handleClick(item.id)> "Remove"