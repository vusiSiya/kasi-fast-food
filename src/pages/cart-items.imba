import { 
	getTotalPrice,
	getCartItems,
	get,
	removeItem,
	updateItemCount 
} from "../../api"
import type {CartItem} from "../../types"

css .total-price bgc: #fffff1 @hover:black c: black @hover: white
	p:.5em fw: bold rd:.28rem 

tag cart-items
	prop data = []

	def handleClick e
		const {id} = e.target
		const item = data.find do(item) item.id === id
		await removeItem(id)
		item.count = 0 

	def handleChange e
		const {id, value} = e.target
		const item = data.find do(item) item.id === id
		let new-count = Number(value)	
		await updateItemCount(item.id, new-count)
		item.count = new-count

	def render
		const items = await get<CartItem[]>(getCartItems)
		this.data = items

		<self[d:grid g:.5em]>
			<div [d:flex ai:center]>	
				<h1 [m:.8em 3.2rem c:white]> "On your cart" 
				<p.total-price> 
					<i.fa-solid .fa-coins .fa-beat-fade> 
					" R {await getTotalPrice! || 0}"
					
			<div.container [d:vflex]>
				if !items
					<section [d:grid ji:center m:5em auto p:2rem c:white]>
						<h2 [m:auto 0]> "Nothing here, yet." 
				else

					for item in [...items]  # spreading for typesafety
						unless !item.count
							<div.menu-item [td:none ai:flex-end g:1em w:auto mx: 3.2em @!760: auto mt: .5em]>
								<img.item-image width="240" src=item.imgUrl alt=item.name />

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
											title="Delete"
											@mousedown.flag('busy', 'div').wait(500ms)=handleClick
										>
												