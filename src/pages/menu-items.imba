import{ getAllItems } from "../../api.js"

tag menu-items
	items = getAllItems()
	<self.container 
		[d:grid @!700:vflex g: 2rem grid-template-columns:repeat(3, auto) w:100% jc:center m: 2rem auto 0]
		
	>
		for item,i in items
			unless i > 5
				<a.menu-item [d:grid max-width:max-content m:auto]
					id=item.id
					route-to="/items/{item.id}"
					@click=emit("itemClicked")
				>
					<img.item-image [w:100%] src=item.imgUrl/>
					<div.item-content>
						<h2.item-name> item.name
						<h3.item-price> "R {item.price}"