
import "./components/layout.imba"
import {getAllItems} from "../api.js"

global css 
	html,body m:0
	body bgc: #527e7a fs:1rem ff:Arial d:grid g:.25em w:100% 

	a c:inherit td:none

	.container d:flex jc:center g:1rem w:100%
	.count bgc: #c51950 rd: 100%  c: white p: .25em .5em fw:bold

	.menu-item d:flex g:1rem p:.5em bgc: #ffffe0c2 c:black max-width:53rem
		rd: .5rem box-shadow: none @hover: 0 0 18px 8px #344544 

	.menu-item@!760 d:grid ai:flex-end m:0 auto max-width: max-content 
	
	.item-image w:100% max-width:19rem aspect-ratio:1  rd:.27rem 

	.item-content d:grid g:1rem
	.item-name, .item-price m: .75rem 0 .125rem
	
	.item-count-input 	
		bd:4px solid #537f7b @hover:4px #689F38 rd: .25rem
		ta: center fs: medium  w: auto p: .25em .5em m:0

	.cart-btn 
		bd: 2px solid black rd: .25rem fs: larger fw: bold 
		p: .325rem .9em c:inherit @hover:white bgc:white @hover:black 

tag app

	prop items = getAllItems!
	prop item-detail

	def getBoughtItems
		const newArray = items.filter do(item) item.count
		return newArray

	def handleItemClick e
		item-detail = e.detail
		return

	<self>
		<layout @itemClick=handleItemClick>
			<login route="/login"> 
			<menu-items route="/items">
			<bought-items route="/bought-items" boughtItems=getBoughtItems()>
			
			item-detail && (
				<div.container [d:vflex g:0] route="/item-detail/:id">
					<a route-to="/items" [m:1rem c:white] > "← back to menu"

					<div.menu-item [ai:flex-end g:1em m:.5em 3.2em w:auto min-width:max-content]>
						<img.item-image src=item-detail.imgUrl alt="{item-detail.name}"/>
						<div.item-content>
							<h2.item-name> item-detail.name
							<p.item-price> "R {item-detail.price}"
							
							<div [d:flex ai:center g: .75em]>
								if item-detail.count > 3
									<input.item-count-input
										type="number"
										bind=item-detail.count 
										@change=(do(e)item-detail.count = Number(e.target.value))
									/>
									<button> "Remove"
								else 
									<button.cart-btn @click=item-detail.count++> "Add To Cart"
									<span.count .fa-beat> item-detail.count	
			)


imba.router.alias("/", "/items");
imba.mount do <app>
