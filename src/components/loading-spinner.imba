
tag loading-spinner > section
	def render
		imba.commit!
		<self  [m:5em auto c:white]>
			<h2> <i.fa-solid .fa-spinner .fa-spin-pulse>
			