import { 
	getCartItems,
	redirect,
	_catch,
	removeItem,
	updateItemCount 
} from "../../api"
import {checkAuthState} from "../../auth"
import type {CartItem} from "../../types"

css .total-price bgc: #fffff1 @hover:black c: black @hover: white
	p:.5em fw: bold rd:.28rem 


tag cart-items
	prop data = []
	error = {id:0, msg: ""}

	def handleClick e
		try
			const {id} = e.target
			const item = data.find do(item) item.id === id
			this.error.id = id
			await removeItem(id)
			item.count = 0 
		catch err
			this.error.msg = err.message	

	def handleChange e
		try
			const {id, value} = e.target
			const item = data.find do(item) item.id === id
			let newCount = Number(value)

			if (newCount > 0 && newCount <= 15)
				await updateItemCount(item.id, newCount)
			else if (newCount < 0 || newCount > 15)
				newCount = newCount < 1 ? 1 : 15
				await updateItemCount(item.id, newCount)
				item.count = newCount
				this.error.id = item.id
				throw new Error("Enter a value from 1 - 15")
			else if (newCount == 0)
				newCount = 0
				await removeItem(item.id)
				item.count = newCount;
			

		catch err
			this.error.msg = err.message		


	def render	
		const url = new URL(window.location.href)
		const authenticated = url.searchParams.get("auth") === "true"
		if !authenticated then redirect("not-signed-in", 2)

		# this.data = await _catch<CartItem[]>(getCartItems)
		
		const totalPrice = data && data.reduce(&, 0) do(sum, item) 
			sum + item.price * item.count
		
		const limitError = "Enter a value from 1 - 15"

		<self[d:grid g:.5em]>
			<div [d:flex ai:center]>	
				<h1 [m:.8em 3.2rem c:white]> "On your cart" 
				<p.total-price> 
					<i.fa-solid .fa-coins .fa-beat-fade> 
					" R {totalPrice || 0}"
					
			<div.container [d:vflex]>
				if !data
					<loading-spinner> 
					
				else if !totalPrice
					<section [d:grid ji:center m:5em auto p:2rem c:white]>
						<p [m:auto 0 fs:large]> "Nothing here  ¯\_(ツ)_/¯"
			
				else if data
					for item in data 
						<div.menu-item [td:none ai:flex-end g:1em w:auto mx: 3.2em @!760: auto mt: .5em]>
							<img.item-image width="240" src=item.imgUrl alt=item.name />

							<div.item-content [ai:end g:1.4em]>
								<h3.item-name> item.name
								<p.item-price> "R {item.price}"

								if (error.msg && error.id === item.id)
									<error-message 
										bind:msg=error.msg 
										specialMsg=limitError
									/>

								<div [d:flex ai:center g: .5em]>
									<input.item-count-input
										type="number"
										min="0"
										max="15"
										id=item.id 	
										value=item.count
										@change.flag('busy', 'input').wait(150ms)=handleChange
									/>
									<i.remove-item .fa-solid .fa-trash-can 
										id=item.id
										title="Delete"
										@mousedown.flag('busy', 'div').wait(300ms)=handleClick
									>
								