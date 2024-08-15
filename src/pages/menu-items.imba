
import { getAllItems, get } from "../../api"
import type {Item} from "../../types"

tag menu-items
	prop items = []

	def render
		items = await get<Item[]>(getAllItems)
		<self.container>
			css d:grid @!700:vflex jc:center g:2rem gtc:repeat(3, auto)
				w:100% m:2rem auto 0

			if !items.length	 
				<loading-spinner>	
			else 
				for item in items
					<a .menu-item [d:grid m:auto]
						id=item.id
						route-to="/item-detail/{item.id}"
					>
						<img.item-image width="240" src=item.imgUrl />
						<div.item-content>
							<h2.item-name> item.name
							<h3.item-price> "R {item.price}"
				
			
