

tag error-message
	prop msg = null
	prop specialMsg = null

	<self>
		if (msg === specialMsg)
			<span [c:red m:0]> msg
		else if (msg)
			<span [c:red m:0]> "Oops, an error occured"
		<[d:none]> msg = null 
