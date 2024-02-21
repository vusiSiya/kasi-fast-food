
tag login
	css 
		form 
			d: grid g: 1em bgc: black w: 15em m: 1em auto p: 1em c: white 
			fs: inherit bd: none rd: .5rem 
			  
		form > input 
			bd: 5px solid transparent @hover:5px solid blue3 rd: .25rem
			w: auto p: .5em fs: large bw: 5px ta: start 
				
		form > button 
			fs: large fw: bold p: 1em 1.5em bd: none rd: .5rem c: inherit
			bgc: #344544 @hover:orange 
			
	<self.container [margin:auto]>
		<form>
			<h5 [ta:center] > "Login or Sign Up"
			<input type="text" name="username" placeholder="name" required/>
			<input type="password" name="password" placeholder="password" required />
			<label [fs: 1rem] htmlFor="remember-me">
				<input type="checkbox" name="remember-me"  title="Remember me" />
				<span> "Remember me"
			<button type="submit" > "Login"
			<button type="button"> "Sign Up"