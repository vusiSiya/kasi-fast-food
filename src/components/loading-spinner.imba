
tag loading-spinner > section
	def render
		imba.commit!
		<self  [m:5em auto c:white]>
			<p> "loading data " 
				<i .fa-solid .fa-spinner .fa-spin-pulse>