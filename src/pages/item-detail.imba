import {getSingleItem} from "../../api.js"
	 
css .cart-btn 
		bd: 2px solid black rd: .25rem fs: larger fw: bold 
		p: .325rem .9em c:inherit @hover:white bgc:white @hover:black 

const getStoredData = do()
	const unknownKey = localStorage.key(0)
	const data = localStorage.getItem unknownKey
	localStorage.clear()
	localStorage.clear()
	imba.commit!
	return data

tag item-detail
	prop itemId  = getStoredData!
	prop item
	# item = (do getData())!

	def snatchData info
		return info
	def getData
		const id = itemId || getStoredData!
		const newItem = await getSingleItem(id)
		item = snatchData(newItem)
		
	def handleChange e
		item.count = Number(e.target.value)

	<self.container [d:vflex g:0] >
		<a route-to="/items" [m:1rem 2rem @!760:1rem c:white] > "← back to menu"
		if !item
			<section [m:5em auto c:white]> 
				<p> "loading " 
					<i .fa-solid .fa-spinner .fa-spin-pulse>
		else
			<div.menu-item [m:.5em 3.2em @!760:auto ai:flex-end w:auto g:1em min-width:max-content]>
				<img.item-image src=item.imgUrl alt="{item.name}"/>
				<div.item-content>
					<h2.item-name> item.name
					<p.item-price> "R {item.price}"
					
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
			
			
