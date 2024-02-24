import{ getAllItems } from "../../api.js"

tag menu-items
	items = getAllItems()
	<self.container [w:100% d:flex flex-wrap:wrap jc:center mt:2em]>
		for item,i in items
			unless i > 5
				<a.menu-item route-to="/items/{item.id}" [g:1em p: .5em]>
					<img.item-image [w:100%] src=item.imgUrl>
					<div.item-content [g:0]>
						<h2.item-name> item.name
						<h3.item-price> "R {item.price}"