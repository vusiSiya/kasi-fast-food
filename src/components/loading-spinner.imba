
tag loading-spinner > section
	<self  [m:5em auto c:white]>
		console.log("rendered")
		<h2> <i.fa-solid .fa-spinner .fa-spin-pulse>
		<[d:none]> setTimeout(&, 725) do imba.commit!
			