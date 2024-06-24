
tag menu-items
	prop items
	
	<self.container [d:grid @!700:vflex g: 2rem gtc:repeat(3, auto) w:100% jc:center m: 2rem auto 0]>
		if !items.length
			<loading-spinner>
		else 
			for item in items
				<a.menu-item [d:grid m:auto]
					id=item.id
					route-to="/item-detail/{item.id}"
				>
					<img.item-image [w:100%] src=item.imgUrl />
					<div.item-content>
						<h2.item-name> item.name
						<h3.item-price> "R {item.price}"
		
