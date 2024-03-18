import{ getAllItems} from "../../api.js"

tag menu-items
	items = getAllItems()

	# def handleItemClick itemId
	#	document.location.replace("/item-detail/{itemId}")

	<self.container 
		[d:grid @!700:vflex g: 2rem grid-template-columns:repeat(3, auto) w:100% jc:center m: 2rem auto 0]
	>
		for item,i of items
				<a.menu-item [d:vflex m:auto]
					id=item.id
					route-to="/item-detail/{item.id}"
					@click.emit("itemClick", item)
				>
					<img.item-image [w:100%] src=item.imgUrl />
					<div.item-content>
						<h2.item-name> item.name
						<h3.item-price> "R {item.price}"