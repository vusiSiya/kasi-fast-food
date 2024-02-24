import {removeItem, getAllItems} from "../../api.js"

css .cart-btn 
	c:inherit @hover:white bgc: inherit @hover:black
	fs: larger fw: bold p: .325rem .9em 
	bd: 1px solid black rd: .25rem 

const pathname = document.location.pathname
const getParamsId = do Number(pathname[pathname.length - 1])

tag item-detail
	prop itemId = getParamsId!# id will be recieved from params.id
	prop item = getAllItems().find do(item) item.id === Number(itemId) # would be an api call 
   
	def handleChange e
		item.count = Number(e.target.value)

	<self.container [d:vflex g:0]>
		<a route-to="/items" [m:1rem c:white]> "← back to menu"

		<div.menu-item [d:flex ai:flex-end g:2em m: 1em 3.2em w:auto min-width:max-content]>
			<img.item-image src="/{item.imgUrl}">
			<div.item-content>
				<h1.item-name> item.name
				<h2.item-price> "R {item.price}"
				
				<div [d:flex ai:center g: .75em]>
					if (item.count > 3)
						<input.item-count-input
							type="number"
							bind=item.count 
							@change=handleChange(e)
						/>
						<button> "Remove"		
					else 
						<button.cart-btn @click=item.count++ > "Add To Cart"
						<a route-to="/bought-items/count?={item.count}">
							<span.count [m:0]> "{item.count}"			
